//
//  FeedVC.swift
//  Stage
//
//  Created by Eric Huang on 2016/7/4.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {
    
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    

    
    
    override func viewDidLoad() {
        
        if revealViewController() != nil {
            menuBtn.target = self.revealViewController()
            menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        }
        
        // slide open menu
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }

    
}
