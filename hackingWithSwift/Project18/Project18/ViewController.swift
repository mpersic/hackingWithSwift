//
//  ViewController.swift
//  Project18
//
//  Created by COBE on 14/06/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print ("Inside viewDidLoad() method")
        print (1,2,3, separator: "-", terminator: "")
        for i in 1...100 {
            print("Got number \(i)")
        }
    }


}

