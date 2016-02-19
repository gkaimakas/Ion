//
//  SectionListener.swift
//  Pods
//
//  Created by George Kaimakas on 11/18/15.
//
//

public protocol SectionListener {

    func sectionDidChangeState(section: Section)
    func sectionInputDidChangeValue(section: Section, input: Input)
    func sectionWasSubmitted(section: Section)
}
