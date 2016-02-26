//
//  DateInput.swift
//  Pods
//
//  Created by Γιώργος Καϊμακάς on 26/02/16.
//
//

import Foundation

public class DateInput: Input {
    public let hint: String
    
    public init(name: String, hint: String) {
        self.hint = hint
        super.init(name: name)
    }
}