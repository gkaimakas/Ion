//
//  InputListener.swift
//  Pods
//
//  Created by George Kaimakas on 11/18/15.
//
//

public protocol InputListener {
    func inputDidChangeValue(input: Input)
    func inputDidChangeState(input: Input)
    func inputWasSubmitted(input: Input)
    func inputWasForceValidated(input: Input)
}
