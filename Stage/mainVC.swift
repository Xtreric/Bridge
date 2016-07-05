//
//  mainVC.swift
//  Stage
//
//  Created by WeBIM RD on 2016/7/4.
//  Copyright © 2016 WeBIM Services. All rights reserved.
//

import Foundation
import UIKit



class mainVC : UIViewController {
    

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    @IBOutlet weak var testBtn: UIButton!
    
    
    
    @IBAction func menuBtn_Click(sender: AnyObject) {
        print("btn1click")
    }
    
    @IBAction func testBtn_Click(sender: AnyObject) {
        print("btn2click")
    }
    
    
    
    
    override func viewDidLoad() {
        menuBtn.target = self.revealViewController()
        menuBtn.action = Selector("revealToggle:")
        
        // slide open menu
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        }
        

    
}