//
//  InputTextView.swift
//  Pods
//
//  Created by Γιώργος Καϊμακάς on 19/02/16.
//
//

import Foundation
import UIKit

open class TextInputField: UITextField {
    
	open var input: TextInput? = nil {
		didSet {
			if let input = input {
				
			} else {
				delegate = nil
				isSecureTextEntry = false
				keyboardType = .default
				inputView = nil
			}
		}
	}
		
    open func setInput(_ input: TextInput) {
        self.delegate = self
        self.input = input
        
        if let passwordInput = self.input as? PasswordInput {
            isSecureTextEntry = true
            keyboardType = .default
            inputView = nil
            
            return
        }
        
        if let emailInput = self.input as? EmailInput {
            isSecureTextEntry = false
            keyboardType = .emailAddress
            inputView = nil
            
            return
        }
		
		if let PhoneInput = self.input as? PhoneInput {
			isSecureTextEntry = false
			keyboardType = UIKeyboardType.phonePad
			inputView = nil
		}
    }
    
    
}

extension TextInputField: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let input = input {
            let newValue = (text! as NSString).replacingCharacters(in: range, with: string)
            input.setValue(newValue)
        }
        
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, let input = self.input {
            input.setValue(text)
        }
    }
}
