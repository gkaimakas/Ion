//
//  SwitchInputView.swift
//  Pods
//
//  Created by Γιώργος Καϊμακάς on 26/02/16.
//
//

import Foundation
import UIKit

open class SwitchInputView: UISwitch {
    fileprivate var input: SwitchInput?
    
    open func setInput(_ input: SwitchInput) {
        self.input = input
        self.addTarget(self, action: #selector(SwitchInputView.handleSwitch), for: .valueChanged)
    }
    
    func handleSwitch() {
        if self.isOn {
            input?.setOn()
        } else {
            input?.setOff()
        }
    }
}
