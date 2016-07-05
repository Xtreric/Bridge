//
//  thirdPage.swift
//  Stage
//
//  Created by Eric Huang on 2016/7/1.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

import Foundation
import UIKit



class thirdPage : UIViewController {

    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    
    override func viewDidLoad() {
    
        menuBtn.target = self.revealViewController()
        menuBtn.action = Selector("revealToggle:")
        
        // slide open menu
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
}

