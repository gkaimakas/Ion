//
//  DateInputField.swift
//  Pods
//
//  Created by Γιώργος Καϊμακάς on 26/02/16.
//
//

import Foundation
import UIKit

public class DateInputField: UITextField {
    public static let DefaultDateFormat = "dd-MM-yyyy"
    
    private var input: DateInput?
    private let datePicker = UIDatePicker()
    
    public var dateFormat: String? = DateInputField.DefaultDateFormat
    
    public func setInput(input: DateInput) {
        self.input = input
        
        datePicker.datePickerMode = .Date
        datePicker.addTarget(self, action: "handleDateSet:", forControlEvents: UIControlEvents.ValueChanged)
        
        inputView = datePicker
    }
    
    func handleDateSet(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        
        if let dateFormat = dateFormat, let input = self.input {
            dateFormatter.dateFormat = dateFormat
            let dateString = dateFormatter.stringFromDate(sender.date)
            text = dateString
            input.setValue(dateString)
        }
    }
}
