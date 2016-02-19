//
//  ViewController.swift
//  Ion
//
//  Created by George Kaimakas on 11/18/2015.
//  Copyright (c) 2015 George Kaimakas. All rights reserved.
//

import UIKit
import Ion
import SwiftValidators

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Form(name: "hello")
            .addSection(
                Section(name: "from the")
                    .addInput(Input(name: "other side")
            )
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

