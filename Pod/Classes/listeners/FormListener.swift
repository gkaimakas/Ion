//
//  FormListener.swift
//  Pods
//
//  Created by George Kaimakas on 11/18/15.
//
//

public protocol FormListener {
    func formIputDidChangeValue(form: Form, section: Section, input: Input)
    func formDidChangeState(form: Form)
    func formWasSubmitted(form: Form)
}
