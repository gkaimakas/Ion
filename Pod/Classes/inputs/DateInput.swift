//
//  DateInput.swift
//  Pods
//
//  Created by Γιώργος Καϊμακάς on 26/02/16.
//
//

import Foundation

open class DateInput: Input {
    open let hint: String
    
    public init(name: String, hint: String) {
        self.hint = hint
        super.init(name: name)
    }
}
