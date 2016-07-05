//
//  mainPage.swift
//  Stage
//
//  Created by Eric Huang on 2016/7/1.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

import Foundation
import UIKit



class mainPage : UIViewController {
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        if revealViewController() != nil {
        menuBtn.target = self.revealViewController()
        menuBtn.action = Selector("revealToggle:")
        }
        
        // slide open menu
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    
    }
    
}