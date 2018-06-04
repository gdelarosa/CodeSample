//
//  ViewController.swift
//  CodeSample
//
//  Created by Gina De La Rosa on 5/30/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.
//  Initial view controller displaying the segement control

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userToDo: UIView!
    @IBOutlet weak var userInfo: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Segment control setup for switching between userInfo and userToDo.
    @IBAction func userInformationSegmentControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.userToDo.alpha = 1
                self.userInfo.alpha = 0
            })
        } else if sender.selectedSegmentIndex == 1 {
            UIView.animate(withDuration: 0.5, animations:  {
                self.userToDo.alpha = 0
                self.userInfo.alpha = 1
            })
        }
    }
}

