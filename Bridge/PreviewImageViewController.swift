//
//  PreviewImageViewController.swift
//  Bridge
//
//  Created by WeBIM RD on 2016/6/27.
//  Copyright © 2016 WeBIM Services. All rights reserved.
//

import UIKit

class PreviewImageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cancelBtn: UIButton!
    
    
    var image: UIImage!
    
    
    init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // CANCEL button
    @IBAction func cancelBtn_Click(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // HIDE STATUS BAR
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = image
    }


}
