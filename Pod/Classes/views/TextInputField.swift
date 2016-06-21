//
//  InputTextView.swift
//  Pods
//
//  Created by Γιώργος Καϊμακάς on 19/02/16.
//
//

import Foundation
import UIKit

public class TextInputField: UITextField {
    
	public var input: TextInput? = nil {
		didSet {
			if let input = input {
				
			} else {
				delegate = nil
				secureTextEntry = false
				keyboardType = .Default
				inputView = nil
			}
		}
	}
		
    public func setInput(input: TextInput) {
        self.delegate = self
        self.input = input
        
        if let passwordInput = self.input as? PasswordInput {
            secureTextEntry = true
            keyboardType = .Default
            inputView = nil
            
            return
        }
        
        if let emailInput = self.input as? EmailInput {
            secureTextEntry = false
            keyboardType = .EmailAddress
            inputView = nil
            
            return
        }
		
		if let PhoneInput = self.input as? PhoneInput {
			secureTextEntry = false
			keyboardType = UIKeyboardType.PhonePad
			inputView = nil
		}
    }
    
    
}

extension TextInputField: UITextFieldDelegate {
    public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if let input = input {
            let newValue = (text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
            input.setValue(newValue)
        }
        
        return true
    }
    
    public func textFieldDidEndEditing(textField: UITextField) {
        if let text = textField.text, let input = self.input {
            input.setValue(text)
        }
    }
}
