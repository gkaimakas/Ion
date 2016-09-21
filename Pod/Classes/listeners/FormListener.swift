//
//  FormListener.swift
//  Pods
//
//  Created by George Kaimakas on 11/18/15.
//
//

public protocol FormListener {
    func formIputDidChangeValue(_ form: Form, section: Section, input: Input)
    func formDidChangeState(_ form: Form)
    func formWasSubmitted(_ form: Form)
}
