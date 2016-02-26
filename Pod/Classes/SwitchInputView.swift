//
//  SwitchInputView.swift
//  Pods
//
//  Created by Γιώργος Καϊμακάς on 26/02/16.
//
//

import Foundation
import UIKit

public class SwitchInputView: UISwitch {
    private var input: SwitchInput?
    
    public func setInput(input: SwitchInput) {
        self.input = input
        self.addTarget(self, action: "handleSwitch", forControlEvents: .ValueChanged)
    }
    
    func handleSwitch() {
        if self.on {
            input?.setOn()
        } else {
            input?.setOff()
        }
    }
}
