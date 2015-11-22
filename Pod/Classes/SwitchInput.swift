//
//  SwitchInput.swift
//  Pods
//
//  Created by George Kaimakas on 11/19/15.
//
//


public class SwitchInput: Input {
    public static let ON_VALUE = "true"
    public static let OFF_VALUE = "false"
    
    public let description: String
    
    public init(name: String, description: String) {
        self.description = description
        super.init(name: name, value: SwitchInput.OFF_VALUE)
    }

    public init(copy: SwitchInput) {
        self.description = copy.description
        super.init(copy: copy)
    }
    
    public override func copy() -> SwitchInput {
        return SwitchInput(copy: self)
    }
    
    public var isOn: Bool{
        return self.getValue() == SwitchInput.ON_VALUE
    }
    
    public func setOn(){
        setValue(SwitchInput.ON_VALUE)
    }
    
    public func setOff(){
        setValue(SwitchInput.OFF_VALUE)
    }
}
