//
//  TextInput.swift
//  Pods
//
//  Created by George Kaimakas on 11/19/15.
//
//

import UIKit

open class TextInput: Input {
    open let hint:String
    
    public init(name: String, hint: String) {
        self.hint = hint
        super.init(name: name)
    }

    public init(copy: TextInput) {
        self.hint = copy.hint
        super.init(copy: copy)
    }

    open override func copy() -> TextInput {
        return TextInput(copy: self)
    }
}
