//
//  SelectInputField.swift
//  Pods
//
//  Created by Γιώργος Καϊμακάς on 26/02/16.
//
//

import Foundation
import UIKit

public class SelectInputField: UITextField {
    private var input: SelectInput? = nil
    
    public func setInput(input: SelectInput) {
        self.input = input
        self.delegate = self
        
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        inputView = picker
    }
}

//MARK: - UITextFieldDelegate

extension SelectInputField: UITextFieldDelegate {
    public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}

//MARK: - UIPickerViewDataSource

extension SelectInputField: UIPickerViewDataSource {
    
    public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let input = self.input {
            return input.numberOfOptions
        }
        
        return 0
    }
}

//MARK: - UIPickerViewDelegate

extension SelectInputField: UIPickerViewDelegate {
    
    public func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let input = self.input {
            input.selectOptionAtIndex(row)
            text = input.optionForIndex(row).displayValue
        }
    }
    
    public func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let input = self.input {
            return input.optionForIndex(row).displayValue
        }
        
        return nil
    }
    
}
