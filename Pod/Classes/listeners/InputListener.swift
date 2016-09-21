//
//  InputListener.swift
//  Pods
//
//  Created by George Kaimakas on 11/18/15.
//
//

public protocol InputListener {
    func inputDidChangeValue(_ input: Input)
    func inputDidChangeState(_ input: Input)
    func inputWasSubmitted(_ input: Input)
    func inputWasForceValidated(_ input: Input)
}
