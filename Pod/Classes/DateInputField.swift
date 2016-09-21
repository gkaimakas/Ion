//
//  DateInputField.swift
//  Pods
//
//  Created by Γιώργος Καϊμακάς on 26/02/16.
//
//

import Foundation
import UIKit

open class DateInputField: UITextField {
    open static let DefaultDateFormat = "dd-MM-yyyy"
    
    fileprivate var input: DateInput?
    fileprivate let datePicker = UIDatePicker()
    
    open var dateFormat: String? = DateInputField.DefaultDateFormat
    
    open func setInput(_ input: DateInput) {
        self.input = input
        
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(DateInputField.handleDateSet(_:)), for: UIControlEvents.valueChanged)
        
        inputView = datePicker
    }
    
    func handleDateSet(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        
        if let dateFormat = dateFormat, let input = self.input {
            dateFormatter.dateFormat = dateFormat
            let dateString = dateFormatter.string(from: sender.date)
            text = dateString
            input.setValue(dateString)
        }
    }
}
