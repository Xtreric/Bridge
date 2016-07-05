//
//  backTableVC.swift
//  Stage
//
//  Created by Eric Huang on 2016/6/30.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

import Foundation

class backTableVC: UITableViewController {
    
    var TableArray = [String]()
    
    
    override func viewDidLoad() {
        
    }
    

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(TableArray[indexPath.row], forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = TableArray[indexPath.row]
        return cell
        
    }
    
    
    
    
    
    
}
