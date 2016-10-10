//
//  SelectInput.swift
//  Pods
//
//  Created by George Kaimakas on 12/3/15.
//
//

open class SelectInput: Input {
    public struct Option {
        public let value: String
        public let displayValue: String
        
        public init (displayValue: String, value:String) {
            self.value = value
            self.displayValue = displayValue
        }
    }
    
    fileprivate var options = [Option]()
    
    open let description: String

	public var selectedOption: Option? {
		return options
			.filter() { $0.value == self.value }
			.first
	}

	public var selectedOptionIndex: Int? {
		return options.enumerated()
			.filter() { $0.element.value == self.value }
			.map() { $0.offset }
			.first
	}
    
    //MARK: - Computed Properties
    
    open var numberOfOptions: Int {
        return options.count
    }
    
    public init(name: String, description: String) {
        self.description = description
        super.init(name: name)
    }
    
    open func addOption(_ option: Option) -> SelectInput {
        self.options.append(option)
        return self
    }
    
    open func addOption(_ displayValue:String, value:String) -> SelectInput {
        return self.addOption(Option(displayValue: displayValue, value: value))
    }
    
    open func optionForIndex(_ index:Int) -> Option {
        return options[index]
    }
    
    open func selectOptionAtIndex(_ index: Int) {
        let option = options[index]
        self.setValue(option.value)
    }
    
    open func selectOptionWithDisplayValue(_ displayValue: String) {
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
