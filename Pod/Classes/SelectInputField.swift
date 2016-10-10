//
//  SelectInputField.swift
//  Pods
//
//  Created by Γιώργος Καϊμακάς on 26/02/16.
//
//

import Foundation
import UIKit

open class SelectInputField: UITextField {
    fileprivate var input: SelectInput? = nil
    
    open func setInput(_ input: SelectInput) {
        self.input = input
        self.delegate = self
        
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        inputView = picker

		if let selectedIndex = input.selectedOptionIndex,
			let selectedOption = input.selectedOption {

			if selectedIndex < input.numberOfOptions {
				picker.selectRow(selectedIndex, inComponent: 0, animated: true)
				self.text = selectedOption.displayValue
			}
		}
		
    }
}

//MARK: - UITextFieldDelegate

extension SelectInputField: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}

//MARK: - UIPickerViewDataSource

extension SelectInputField: UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let input = self.input {
            return input.numberOfOptions
        }
        
        return 0
    }
}

//MARK: - UIPickerViewDelegate

extension SelectInputField: UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let input = self.input {
            input.selectOptionAtIndex(row)
            text = input.optionForIndex(row).displayValue
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let input = self.input {
            return input.optionForIndex(row).displayValue
        }
        
        return nil
    }
    
}
