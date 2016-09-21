//
//  ValidationRule.swift
//  Pods
//
//  Created by George Kaimakas on 11/18/15.
//
//
import SwiftValidators

public struct ValidationRule {
    let rule: Validator
    let errorMessage: String
    
    init(rule: @escaping Validator, errorMessage: String){
        self.rule = rule
        self.errorMessage = errorMessage
    }
}
