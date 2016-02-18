//
//  SelectInput.swift
//  Pods
//
//  Created by George Kaimakas on 12/3/15.
//
//

public class SelectInput: Input {
    public struct Option {
        public let value: String
        public let displayValue: String
        
        public init (displayValue: String, value:String) {
            self.value = value
            self.displayValue = displayValue
        }
    }
    
    private var options = [Option]()
    
    public let description: String
    
    //MARK: - Computed Properties
    
    public var numberOfOptions: Int {
        return options.count
    }
    
    public init(name: String, description: String) {
        self.description = description
        super.init(name: name)
    }
    
    public func addOption(option: Option) -> SelectInput {
        self.options.append(option)
        return self
    }
    
    public func addOption(displayValue:String, value:String) -> SelectInput {
        return self.addOption(Option(displayValue: displayValue, value: value))
    }
    
    public func optionForIndex(index:Int) -> Option {
        return options[index]
    }
    
    public func selectOptionAtIndex(index: Int) {
        let option = options[index]
        self.setValue(option.value)
    }
    
    public func selectOptionWithDisplayValue(displayValue: String) {
        var result: Option? = nil
        for option in options {
            if option.displayValue == displayValue {
                result = option
            }
        }
        
        if let result = result {
            self.setValue(result.value)
        }
    }
    
}
