//
//  PreviewImageViewController.swift
//  Bridge
//
//  Created by WeBIM RD on 2016/6/27.
//  Copyright © 2016 WeBIM Services. All rights reserved.
//

import UIKit
import Photos
import AVFoundation

let albumName = "Bridge"

class PreviewImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var drawImageView: UIImageView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!

    
    var albumFound : Bool = false
    var assetCollection: PHAssetCollection!
    var photosAsset: PHFetchResult!
    var assetThumbnailSize:CGSize!

    // audio record n play
    var soundRecorder : AVAudioRecorder!
    var soundPlayer : AVAudioPlayer!
    var AudioFileName = "sound.m4a"
    
    
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
    

    
    
    var start: CGPoint?
    
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
        CGContextSetRGBStrokeColor(context, 255, 251, 0, 1)
        // 獲取觸控點座標
        CGContextBeginPath(context)
        CGContextMoveToPoint(context, start.x, start.y)
        CGContextAddLineToPoint(context, end.x, end.y)
        // 將Path描繪出
        CGContextStrokePath(context)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        drawImageView.image = newImage
    }
    
    
    let recordSettings = [AVSampleRateKey : NSNumber(float: Float(44100.0)),
                          AVFormatIDKey : NSNumber(int: Int32(kAudioFormatMPEG4AAC)),
                          AVNumberOfChannelsKey : NSNumber(int: 1),
                          AVEncoderAudioQualityKey : NSNumber(int: Int32(AVAudioQuality.Medium.rawValue))]
    

    //HELPERS
    func preparePlayer(){
        
        do {
            try soundPlayer = AVAudioPlayer(contentsOfURL: directoryURL()!)
            soundPlayer.delegate = self
            soundPlayer.prepareToPlay()
            soundPlayer.volume = 1.0
        } catch {
            print("Error playing")
        }
    }
    
    
    func directoryURL() -> NSURL? {
        let fileManager = NSFileManager.defaultManager()
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = urls[0] as NSURL
        let soundURL = documentDirectory.URLByAppendingPathComponent("sound.m4a")
        return soundURL
    }
    
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        playBtn.enabled = true
    }
    
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        recordBtn.enabled = true
        playBtn.setTitle("Play", forState: .Normal)
    }

    
    func setupRecorder(){
        let audioSession:AVAudioSession = AVAudioSession.sharedInstance()
        
        //ask for permission
        if (audioSession.respondsToSelector(#selector(AVAudioSession.requestRecordPermission(_:)))) {
            AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
                if granted {
                    print("granted")
                    
                    //set category and activate recorder session
                    do {
                        try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
                        try self.soundRecorder = AVAudioRecorder(URL: self.directoryURL()!, settings: self.recordSettings)
                        self.soundRecorder.prepareToRecord()
                    } catch {
                        print("Error Recording");
                    }
                }
            })
        }
    }
    
    
    
    
    
    
    // 清除ImageView
    @IBAction func clearBtn_Click(sender: AnyObject) {
        print("clearBtn_click")
        drawImageView.image = nil
    }
    
    // 儲存ImageView
    @IBAction func saveBtn(sender: AnyObject) {
        print("saveBtn_click")
        
        
    }


    
    
    // 錄音鍵
    @IBAction func recordBtn_Click(sender: AnyObject) {
        if sender.titleLabel?!.text == "Record"{
            
            soundRecorder.record()
            sender.setTitle("Stop", forState: .Normal)
            playBtn.enabled = false
        } else {
            soundRecorder.stop()
            sender.setTitle("Record", forState: .Normal)
            playBtn.enabled = true
        }
    }

    // 錄音鍵
    @IBAction func playBtn_Click(sender: AnyObject) {
        if sender.titleLabel?!.text == "Play" {
            
            recordBtn.enabled = false
            sender.setTitle("Stop", forState: .Normal)
            
            preparePlayer()
            soundPlayer.play()
            
        } else{
            soundPlayer.stop()
            sender.setTitle("Play", forState: .Normal)
        }
    }
    
    


    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = image
        
        
        // 建立儲存資料夾
        //Check if the folder exists, if not, create it
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
        let collection:PHFetchResult = PHAssetCollection.fetchAssetCollectionsWithType(.Album, subtype: .Any, options: fetchOptions)
        
        if let first_Obj:AnyObject = collection.firstObject{
            //found the album
            self.albumFound = true
            self.assetCollection = first_Obj as! PHAssetCollection
        }else{
            // Album placeholder for the asset collection, used to reference collection in completion handler
            var albumPlaceholder:PHObjectPlaceholder!
            // create the folder
            NSLog("\nFolder \"%@\" does not exist\nCreating now...", albumName)
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                let request = PHAssetCollectionChangeRequest.creationRequestForAssetCollectionWithTitle(albumName)
                albumPlaceholder = request.placeholderForCreatedAssetCollection
                },
                completionHandler: {(success:Bool, error:NSError?)in
                    if(success){
                        print("Successfully created folder")
                        self.albumFound = true
                        let collection = PHAssetCollection.fetchAssetCollectionsWithLocalIdentifiers([albumPlaceholder.localIdentifier], options: nil)
                        self.assetCollection = collection.firstObject as! PHAssetCollection
                    }else{
                        print("Error creating folder")
                        self.albumFound = false
                    }
            })
        }

        // 錄音
        setupRecorder()

    }

    
    // HIDE STATUS BAR
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
