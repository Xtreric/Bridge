//
//  Drawing.swift
//  Bridge
//
//  Created by Eric Huang on 2016/7/6.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

import UIKit

class Drawing: UIViewController {

    var start: CGPoint?
    
    @IBOutlet weak var drawImageView: UIImageView!
    @IBOutlet weak var clearBtn: UIButton!
    
    
    // HIDE STATUS BAR
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 觸控開始
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first as UITouch!
        start = touch.locationInView(self.drawImageView)
    }
    // 觸控移動
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first as UITouch!
        let end = touch.locationInView(self.drawImageView)

        if let s = self.start {
            draw(s, end: end)
        }
        self.start = end
    }
    
    func draw(start: CGPoint, end: CGPoint) {
        UIGraphicsBeginImageContext(self.drawImageView.frame.size)
        //初始化
        let context = UIGraphicsGetCurrentContext()
        
        drawImageView?.image?.drawInRect(CGRect(x: 0, y: 0, width: drawImageView.frame.width, height: drawImageView.frame.height))
        
        // 圓滑線型
        CGContextSetLineCap(context, CGLineCap.Round)
        // 線寬
        CGContextSetLineWidth(context, 8)
        // 描繪線顏色
        CGContextSetRGBStrokeColor(context, 255, 251, 0, 0.85)
        // 獲取觸控點座標
        CGContextBeginPath(context)
        CGContextMoveToPoint(context, start.x, start.y)
        CGContextAddLineToPoint(context, end.x, end.y)
        // 將Path描繪出
        CGContextStrokePath(context)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        drawImageView.image = newImage
    }
    
    // 清除ImageView
    @IBAction func clearBtn_Click(sender: AnyObject) {
        drawImageView.image = nil
    }
    
    
    

    
    
    
}
