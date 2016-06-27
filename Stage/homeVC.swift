//
//  homeVC.swift
//  Cobweb
//
//  Created by Eric Huang on 2016/6/24.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

import UIKit

class homeVC: UIViewController {
    
    @IBOutlet weak var useridLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var unitLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var companyIDLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // showUserData founction (user = curUserData)
        showUserData(curUserData)
    }
    
    // 將存在curUserData變數的值讀過來的方法
    func showUserData (user: UserData) {
        // 非同步作業
        dispatch_async(dispatch_get_main_queue()) {
            self.useridLbl.text = String(user.UserID)
            self.nameLbl.text = user.Name
            self.unitLbl.text = user.Unit
            self.titleLbl.text = user.Title
            self.emailLbl.text = user.Email
            self.companyIDLbl.text = String(user.CompanyID)
        }
    }
   
    
}
