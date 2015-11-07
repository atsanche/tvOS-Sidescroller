//
//  Home.swift
//  tvOSTemplate
//
//  Created by Justin Dike 2 on 10/6/15.
//  Copyright © 2015 CartoonSmart. All rights reserved.
//

import SpriteKit


enum Colors: String {
    
    case Swatch1 = "#3B3840"
    case Swatch2 = "#343138"
    case Swatch3 = "#222025"
    case Swatch4 = "#1C1B1F"
    case Swatch5 = "#131215"
    case Swatch6 = "#000000"
    case Swatch7 = "#FFFFFF"
    
}


class Home: SKScene {
    
    
    
    
    
    var box:SKSpriteNode?
    var selection:String = "play"
    
    var playLocation:CGPoint = CGPointZero
    var chooseLocation:CGPoint = CGPointZero
    
    var transitionInProgress:Bool = false
    
    
    let swipeRightRec = UISwipeGestureRecognizer()
    let swipeLeftRec = UISwipeGestureRecognizer()
    
    let swipeUpRec = UISwipeGestureRecognizer()
    let swipeDownRec = UISwipeGestureRecognizer()
    
    let tapGeneralSelection = UITapGestureRecognizer()
    let tapPlayPause = UITapGestureRecognizer()
    
    
    
    let colorArray = [Colors.Swatch1.rawValue, Colors.Swatch2.rawValue , Colors.Swatch3.rawValue , Colors.Swatch4.rawValue , Colors.Swatch5.rawValue, Colors.Swatch6.rawValue, Colors.Swatch7.rawValue]
    
    
    var inWhiteMode:Bool = true
    var currentColor:String = Colors.Swatch1.rawValue
    var defaults:NSUserDefaults =  NSUserDefaults.standardUserDefaults()
    
    var testPostingNotifications:Bool = false
    var playBackgroundAudioFromViewController:Bool = false
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        
        if (testPostingNotifications == true){
            
            let dictToSend:[String:String] = [ "theKey": "theValue", ]
            
            
            NSNotificationCenter.defaultCenter().postNotificationName ("PostToViewController", object: self , userInfo:dictToSend)
            
            
            
        }
        
        if ( playBackgroundAudioFromViewController == true){
            
            let dictToSend:[String:String] = [ "fileToPlay": "music", "volume": "1", "loops": "-1" ]
            
            
            NSNotificationCenter.defaultCenter().postNotificationName ("PlayBackgroundMusic", object: self , userInfo:dictToSend)
            
            
        }

        
       
        
        
        if ( defaults.objectForKey("CurrentColor") != nil ) {
            
            currentColor = defaults.objectForKey("CurrentColor") as! String
            self.backgroundColor = Helpers.colorFromHexString(currentColor)
            
        } else {
            
            //there is not already a saved color, so let's save one
            
            defaults.setObject(currentColor, forKey:"CurrentColor")
            self.backgroundColor = Helpers.colorFromHexString(currentColor)
        }
        
        
       
        
        
        
        
        swipeRightRec.addTarget(self, action: "swipedRight")
        swipeRightRec.direction = .Right
        self.view!.addGestureRecognizer(swipeRightRec)
        
        
        swipeLeftRec.addTarget(self, action: "swipedLeft")
        swipeLeftRec.direction = .Left
        self.view!.addGestureRecognizer(swipeLeftRec)
        
        swipeUpRec.addTarget(self, action: "swipedUp")
        swipeUpRec.direction = .Up
        self.view!.addGestureRecognizer(swipeUpRec)
        
        
        swipeDownRec.addTarget(self, action: "swipedDown")
        swipeDownRec.direction = .Down
        self.view!.addGestureRecognizer(swipeDownRec)
        
        
        tapGeneralSelection.addTarget(self, action: "pressedSelect")
        tapGeneralSelection.allowedPressTypes = [NSNumber (integer:  UIPressType.Select.rawValue)]
        self.view!.addGestureRecognizer(tapGeneralSelection)
        
        
        tapPlayPause.addTarget(self, action: "pressedSelect")
        tapPlayPause.allowedPressTypes = [NSNumber (integer:  UIPressType.PlayPause.rawValue)]
        self.view!.addGestureRecognizer(tapPlayPause)
        
        
        if (self.childNodeWithName("Box") != nil ) {
            
            box = self.childNodeWithName("Box") as? SKSpriteNode
            
        }
        
        if (self.childNodeWithName("PlayLabel") != nil ) {
            
           playLocation = CGPointMake( self.childNodeWithName("PlayLabel")!.position.x , self.childNodeWithName("PlayLabel")!.position.y + 25)
            
        }
        if (self.childNodeWithName("ChooseLabel") != nil ) {
            
           chooseLocation = CGPointMake( self.childNodeWithName("ChooseLabel")!.position.x , self.childNodeWithName("ChooseLabel")!.position.y + 25)
            
        }
        
        
        box?.position = playLocation
        
        
        if (currentColor == Colors.Swatch7.rawValue){
            
            inWhiteMode = true
            switchToWhiteMode()
        }
        
       
    }
    
    
    func swipedRight() {
        
        selection = "choose"
        
        box?.removeAllActions()
        
        let move:SKAction = SKAction.moveTo(chooseLocation, duration: 0.5)
        move.timingMode = .EaseOut
        
       box?.runAction(move)
        
    }
    
    
    func swipedLeft() {
        
        selection = "play"
        
        
        box?.removeAllActions()
        
        let move:SKAction = SKAction.moveTo(playLocation, duration: 0.5)
        move.timingMode = .EaseOut
        
        box?.runAction(move)
        
        
    }
    
    func swipedUp() {
        
        var i:Int = 0
        
        for color in colorArray {
            
            if (currentColor == color){
                
                if ( i != 0){
                    
                    
                    currentColor = colorArray[i - 1]
                    
                    defaults.setObject(currentColor, forKey:"CurrentColor")
                    self.backgroundColor = Helpers.colorFromHexString(currentColor)
                    
                    if (currentColor == Colors.Swatch7.rawValue){
                        
                        inWhiteMode = true
                        switchToWhiteMode()
                    } else {
                        
                        inWhiteMode = false
                        switchToNormalMode()
                    }
                    
                    
                }
                
                
                break
            }
            
            i++
            
        }
        
        
        
        
    
    }
    
    func swipedDown() {
        
        
        var i:Int = 0
        
        for color in colorArray {
            
            if (currentColor == color){
            
                if ( i != colorArray.count - 1){
                
                
                    currentColor = colorArray[i + 1]
                    
                    defaults.setObject(currentColor, forKey:"CurrentColor")
                    self.backgroundColor = Helpers.colorFromHexString(currentColor)
                    
                    if (currentColor == Colors.Swatch7.rawValue){
                        
                        inWhiteMode = true
                        switchToWhiteMode()
                    } else {
                        
                        inWhiteMode = false
                        switchToNormalMode()
                    }
                    
                }
            
                
               break
            }
            
            i++
            
        }
        
        
        
    }
    
    
    func switchToWhiteMode(){
        
        if (inWhiteMode == true){
            
            for node in self.children {
                
                if let text = node as? SKLabelNode {
                    
                    text.fontColor = SKColor.grayColor()
                    
                }
                
                
            }
            
            box?.texture = SKTexture(imageNamed: "BoxLineBlack")
            
        }
        
        
        
    }
    
    func switchToNormalMode(){
        
        if (inWhiteMode == false){
            
            for node in self.children {
                
                if let text = node as? SKLabelNode {
                    
                    text.fontColor = SKColor.whiteColor()
                    
                }
                
                
            }

            box?.texture = SKTexture(imageNamed: "BoxLine")
            
        }

        
    }
   
    
    
    func pressedSelect(){
        
        if ( transitionInProgress == false) {
        
            transitionInProgress = true
        
            if ( selection == "play"){
            
                print("selected play")
                loadGame()
            
            } else if ( selection == "choose"){
            
                print("selected choose features")
                loadFeatures()
            }
        
            
        }
        
    }
    
    func loadGame(){
        
        cleanUpScene()
        
        if let scene = GameScene(fileNamed: "GameScene") {
            
            scene.scaleMode = .AspectFill
           
            
            
            self.view?.presentScene(scene, transition: SKTransition.fadeWithColor(Helpers.colorFromHexString(currentColor), duration: 2) )
            
        }
        
        
        
    }
    
    func loadFeatures(){
        
        cleanUpScene()
        
        
        if let scene = Menu(fileNamed: "Menu") {
            
            scene.scaleMode = .AspectFill
            
            self.view?.presentScene(scene, transition: SKTransition.fadeWithColor(Helpers.colorFromHexString(currentColor), duration: 2) )
            
        }
        
        
    }
    
    func cleanUpScene(){
        
        
        if let recognizers = self.view!.gestureRecognizers {
            
            for recognizer in recognizers {
                
                self.view!.removeGestureRecognizer(recognizer as UIGestureRecognizer)
                
            }
            
        }
        
        
        self.removeAllActions()
        
        for node in self.children {
            
            node.removeAllActions()
           // node.removeFromParent()
            
        }
        
        
        
    }
    
    
    
    

}
