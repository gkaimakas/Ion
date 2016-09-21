//
//  SectionListener.swift
//  Pods
//
//  Created by George Kaimakas on 11/18/15.
//
//

public protocol SectionListener {

    func sectionDidChangeState(_ section: Section)
    func sectionInputDidChangeValue(_ section: Section, input: Input)
    func sectionWasSubmitted(_ section: Section)
}
