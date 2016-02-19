//
//  InputTextView.swift
//  Pods
//
//  Created by Γιώργος Καϊμακάς on 19/02/16.
//
//

import Foundation
import UIKit

class InputTextField: UITextField {
    var input: Input? = nil {
        didSet {
            if let input = self.input {
                self.delegate = self
                
                if input is TextInput {
                    return
                }
                
                if input is EmailInput {
                    return
                }
                
                if input is PasswordInput {
                    return
                }
                
                if input is SelectInput {
                    return
                }
                
            }
        }
    }
}

extension InputTextField: UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        
        return true
    }
}
