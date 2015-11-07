//
//  GameViewController.swift
//  tvOSTemplate
//
//  Created by Justin Dike 2 on 10/6/15.
//  Copyright (c) 2015 CartoonSmart. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation


class GameViewController: UIViewController {
    
    
    var bgSoundPlayer:AVAudioPlayer?
    var bgSoundVolume:Float = 1 // 0.5 would be 50% or half volume
    var bgSoundLoops:Int = -1 // -1 will loop it forever
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // comment any of these out if you won't use them....
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "playBackgroundMusic:", name: "PlayBackgroundMusic", object: nil)
        
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "stopBackgroundMusic", name: "StopBackgroundMusic", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receivedNotification:", name: "PostToViewController", object: nil)
        

        if let scene = Home(fileNamed: "Home")  {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
    }
    
    func receivedNotification( notification:NSNotification ){
        
        print ("10-4 ol buddy")
        
       // let name:String  = notification.userInfo!["theKey"] as! String
        
        
        
    }
    
    func playBackgroundMusic( notification:NSNotification ){
        
        
        let name:String  = notification.userInfo!["fileToPlay"] as! String
        let volumeToConvert:NSString = notification.userInfo!["volume"] as! NSString
        let loopsToConvert:NSString = notification.userInfo!["loops"] as! NSString
        
        bgSoundVolume = volumeToConvert.floatValue
        bgSoundLoops = loopsToConvert.integerValue
        
        if (bgSoundPlayer != nil){
            
            bgSoundPlayer!.stop()
            bgSoundPlayer = nil
            
        }
        
        if let fileURL:NSURL = NSBundle.mainBundle().URLForResource(name, withExtension: "mp3") {
        
        do {
            
            bgSoundPlayer = try AVAudioPlayer(contentsOfURL: fileURL)
            
        } catch _{
            
            bgSoundPlayer = nil
        }
        
        
        bgSoundPlayer!.volume = bgSoundVolume
        bgSoundPlayer!.numberOfLoops = bgSoundLoops
        bgSoundPlayer!.prepareToPlay()
        bgSoundPlayer!.play()
        
            
        } else {
            
            
            print(" \(name).mp3 was not found")
        }
        
    }
    
    func stopBackgroundMusic() {
        
        if (bgSoundPlayer != nil){
            
            bgSoundPlayer!.stop()
            bgSoundPlayer = nil
            
            
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
}
