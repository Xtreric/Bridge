//
//  secondPage.swift
//  Stage
//
//  Created by WeBIM RD on 2016/7/1.
//  Copyright © 2016 WeBIM Services. All rights reserved.
//

import Foundation
import UIKit



class secondPage : UIViewController {
    

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        menuBtn.target = self.revealViewController()
        menuBtn.action = Selector("revealToggle:")
        
        // slide open menu
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
}