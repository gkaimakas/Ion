//
//  Input.swift
//  Pods
//
//  Created by George Kaimakas on 11/18/15.
//
//

import SwiftValidators

public class Input {
    public static let DEFAULT_VALUE = ""
    
    public let id: Int64
    public let name: String
    
    private var dirty = false
    private var currentState = false
    private var previousState = false
    private var submitted = false
    
    private let originalValue: String
    private var value: String = Input.DEFAULT_VALUE
    private var previousValue: String?
    
    private var inputListeners = [InputListener]()
    private var validationRules = [ValidationRule]()
    
    //MARK: - Computed Properties
    
    public var data: [String: Any]?{
        if !self.isValid{
            return nil
        }
        return [self.name : self.value]
    }
    
    public var errors:[String]? {
        let errorMessages = validationRules.filter(){
            $0.rule(self.value) == false
            }
            .map{
            $0.errorMessage
        }
        
        if errorMessages.count != 0 {
            return errorMessages
        }
        
        return nil
    }
    
    public var isDirty: Bool {
        return dirty
    }
    
    public var isValid: Bool {
        return self.validate()
    }
    
    public var isSubmitted: Bool {
        return self.submitted
    }
    
    //MARK: - Initializers
    public init(name: String){
        self.id = Int64(NSDate().timeIntervalSince1970 * 1000)
        self.name = name
        self.originalValue = Input.DEFAULT_VALUE
        self.value = Input.DEFAULT_VALUE
        self.previousValue = nil
    }
    
    public init(name: String, value: String){
        self.id = Int64(NSDate().timeIntervalSince1970 * 1000)
        self.name = name
        self.originalValue = value
        self.value = value
        self.previousValue = nil
    }
    
    public init(copy: Input) {
        self.id = Int64(NSDate().timeIntervalSince1970 * 1000)
        self.name = copy.name
        
        self.originalValue = copy.originalValue
        self.value = copy.value
        self.previousValue = copy.previousValue
        
        self.dirty = copy.dirty
        self.currentState = copy.currentState
        self.previousValue = copy.previousValue
        self.submitted = copy.submitted
        
        for rule:ValidationRule in copy.validationRules{
            self.validationRules.append(rule)
        }
        
        // Input Listeners and parentSection must not be copied
    }
    
    public func addInputListener(listener:InputListener) -> Input {
        inputListeners.append(listener)
        return self
    }
    
    public func addValidationRule(rule: Validation, errorMessage: String) -> Input{
        validationRules.append(ValidationRule(rule: rule, errorMessage: errorMessage))
        return self
    }
    
    public func copy() -> Input{
        return Input(copy: self)
    }
    
    public func getValue() -> String{
        return value
    }
    
    //MARK: - Notifications
    internal func notifyIfInputValueChanged(){
        if previousValue! != value {
            for listener:InputListener in inputListeners {
                listener.onInputValueChange(self)
            }
        }
    }
    
    internal func notifyIfInputStateChanged(){
        if previousState != currentState {
            for listener:InputListener in inputListeners{
                listener.onInputStateChange(self)
            }
        }
    }
    
    internal func notifyIfInputSubmitted(){
        if submitted{
            for listener:InputListener in inputListeners{
                listener.onInputSubmitted(self)
            }
        }
    }
    
    public func setCurrentState(state:Bool){
        previousState = currentState
        currentState = state
    }
    
    public func setValue(value:String){
        dirty = true
        previousValue = self.value
        self.value = value
        
        setCurrentState(validate())
        
        notifyIfInputValueChanged()
        notifyIfInputStateChanged()
    }
    
    public func submit(){
        submitted = true
        notifyIfInputSubmitted()
    }
    
    public func validate() -> Bool {
        return validationRules.reduce(true){
            $0 && $1.rule(self.value)
        }
    }
    
    
    
    
}
