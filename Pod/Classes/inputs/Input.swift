//
//  Input.swift
//  Pods
//
//  Created by George Kaimakas on 11/18/15.
//
//

import SwiftValidators

public typealias BeforeValueChangeAction = (Input) -> Void
public typealias AfterValueChangeAction = (Input) -> Void

open class Input {
    open static let DEFAULT_VALUE = ""
    
    open let id: Int64
    open let name: String
    
    fileprivate var dirty = false
    fileprivate var currentState = false
    fileprivate var previousState = false
    fileprivate var submitted = false
    
    fileprivate let originalValue: String
    public var value: String = Input.DEFAULT_VALUE
    fileprivate var previousValue: String?
    
    fileprivate var inputListeners = [InputListener]()
    fileprivate var validationRules = [ValidationRule]()
    
    fileprivate var beforeValueChangeActions: [BeforeValueChangeAction] = []
    fileprivate var afterValueChangeActions: [AfterValueChangeAction] = []
    
    //MARK: - Computed Properties
    
    open var data: [String: Any]?{
        if !self.isValid{
            return nil
        }
        return [self.name : self.value]
    }
    
    open var errors:[String]? {
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
    
    open var isDirty: Bool {
        return dirty
    }
    
    open var isValid: Bool {
        return self.validate()
    }
    
    open var isSubmitted: Bool {
        return self.submitted
    }
    
    //MARK: - Initializers
    public init(name: String){
        self.id = Int64(Date().timeIntervalSince1970 * 1000)
        self.name = name
        self.originalValue = Input.DEFAULT_VALUE
        self.value = Input.DEFAULT_VALUE
        self.previousValue = nil
    }
    
    public init(name: String, value: String){
        self.id = Int64(Date().timeIntervalSince1970 * 1000)
        self.name = name
        self.originalValue = value
        self.value = value
        self.previousValue = nil
    }
    
    public init(copy: Input) {
        self.id = Int64(Date().timeIntervalSince1970 * 1000)
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
    
    open func addInputListener(_ listener:InputListener) -> Input {
        inputListeners.append(listener)
        return self
    }
    
    open func addValidationRule(_ rule: @escaping Validator, errorMessage: String) -> Input{
        validationRules.append(ValidationRule(rule: rule, errorMessage: errorMessage))
        return self
    }
    
    open func copy() -> Input{
        return Input(copy: self)
    }
    
    open func forceValidate() {
        setCurrentState(validate())
        notifyIfInputForcedValidate()
        notifyIfInputValueChanged()
        notifyIfInputStateChanged()
    }
    
    //MARK: - Notifications
    internal func notifyIfInputValueChanged(){
        if let previousValue = self.previousValue {
            if previousValue != value {
                for listener:InputListener in inputListeners {
                    listener.inputDidChangeValue(self)
                }
            }
        }
    }
    
    internal func notifyIfInputStateChanged(){
        if previousState != currentState {
            for listener:InputListener in inputListeners{
                listener.inputDidChangeState(self)
            }
        }
    }
    
    internal func notifyIfInputSubmitted(){
        if submitted{
            for listener:InputListener in inputListeners{
                listener.inputWasSubmitted(self)
            }
        }
    }
    
    internal func notifyIfInputForcedValidate(){
        for listener: InputListener in inputListeners {
            listener.inputWasForceValidated(self)
        }
    }
    
    open func afterValueChange(_ action: @escaping AfterValueChangeAction) -> Input {
        afterValueChangeActions.append(action)
        return self
    }
    
    open func beforeValueChage(_ action: @escaping BeforeValueChangeAction) -> Input{
        beforeValueChangeActions.append(action)
        return self
    }
    
    open func setCurrentState(_ state:Bool){
        previousState = currentState
        currentState = state
    }
    
    open func setValue(_ value:String){
        dirty = true
        previousValue = self.value
		
		for action in beforeValueChangeActions {
			action(self)
		}
        
        self.value = value
		
		for action in afterValueChangeActions {
			action(self)
		}
        
        setCurrentState(validate())
        
        notifyIfInputValueChanged()
        notifyIfInputStateChanged()
    }
    
    open func submit(){
        submitted = true
        notifyIfInputSubmitted()
    }
    
    open func validate() -> Bool {
        return validationRules.reduce(true){
            $0 && $1.rule(self.value)
        }
    }
}

extension Input: ValueProvider {
    public func getValue() -> String{
        return value
    }
}
