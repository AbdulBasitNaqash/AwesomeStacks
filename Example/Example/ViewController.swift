//
//  ViewController.swift
//  Example
//
//  Created by Abdul Basit on 05/09/20.
//  Copyright © 2020 Abdul Basit. All rights reserved.
//

import UIKit
import AwesomeStack

class ViewController: UIViewController {

    @IBOutlet weak var awsomeStack: AwesomeStack!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let customView1 = CustomView1()
        let customView2 = CustomView2()
        let customView3 = CustomView3()
        let customView4 = CustomView4()
        
        awsomeStack.addView(view: customView1)
        awsomeStack.addView(view: customView2)
        awsomeStack.addView(view: customView3)
        awsomeStack.addView(view: customView4)
        awsomeStack.addView(view: customView4)
    }
}

