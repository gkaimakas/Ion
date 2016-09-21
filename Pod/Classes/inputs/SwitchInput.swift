//
//  SwitchInput.swift
//  Pods
//
//  Created by George Kaimakas on 11/19/15.
//
//


open class SwitchInput: Input {
    open static let ON_VALUE = "true"
    open static let OFF_VALUE = "false"
    
    open let description: String
    
    public init(name: String, description: String) {
        self.description = description
        super.init(name: name, value: SwitchInput.OFF_VALUE)
    }

    public init(copy: SwitchInput) {
        self.description = copy.description
        super.init(copy: copy)
    }
    
    open override func copy() -> SwitchInput {
        return SwitchInput(copy: self)
    }
    
    open var isOn: Bool{
        return self.getValue() == SwitchInput.ON_VALUE
    }
    
    open func setOn(){
        setValue(SwitchInput.ON_VALUE)
    }
    
    open func setOff(){
        setValue(SwitchInput.OFF_VALUE)
    }
}
