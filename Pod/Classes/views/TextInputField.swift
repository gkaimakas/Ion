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
    
    private var input: TextInput? = nil
    
    public func setInput(input: TextInput) {
        self.delegate = self
        self.input = input
        
        if let passwordInput = self.input as! PasswordInput? {
            return
        }
        
        if let emailInput = self.input as! EmailInput? {
            return
        }
    }
    
    
}

extension TextInputField: UITextFieldDelegate {
    public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        
        return true
    }
}
