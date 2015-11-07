//
//  Features.swift
//  tvOSTemplate
//
//  Created by Justin Dike 2 on 10/6/15.
//  Copyright © 2015 CartoonSmart. All rights reserved.
//

import SpriteKit

class Menu: SKScene {
    
    
    var transitionInProgress:Bool = false
    let tapMenu = UITapGestureRecognizer()
    
    var box:SKSpriteNode?
    var selection:String = "home"

    
    let swipeRightRec = UISwipeGestureRecognizer()
    let swipeLeftRec = UISwipeGestureRecognizer()
    let swipeUpRec = UISwipeGestureRecognizer()
    let swipeDownRec = UISwipeGestureRecognizer()
    
    let tapGeneralSelection = UITapGestureRecognizer()
    let tapPlayPause = UITapGestureRecognizer()
    
    
    var selectionDict = [String: CGPoint]()
    
    var inWhiteMode:Bool = true
    var currentColor:String = Colors.Swatch1.rawValue
    var defaults:NSUserDefaults =  NSUserDefaults.standardUserDefaults()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        
        if ( defaults.objectForKey("CurrentColor") != nil ) {
            
            currentColor = defaults.objectForKey("CurrentColor") as! String
            self.backgroundColor = Helpers.colorFromHexString(currentColor)
            
        } else {
            
            //there is not already a saved color, so let's save one
            
            defaults.setObject(currentColor, forKey:"CurrentColor")
            self.backgroundColor = Helpers.colorFromHexString(currentColor)
        }
        
        
        tapMenu.addTarget(self, action: "tappedMenu")
        tapMenu.allowedPressTypes = [NSNumber (integer:  UIPressType.Menu.rawValue)]
        self.view!.addGestureRecognizer(tapMenu)
        
        
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
        
        
        if (self.childNodeWithName("HomeLabel") != nil ) {
            
            
            selectionDict["home"] = CGPointMake( self.childNodeWithName("HomeLabel")!.position.x, self.childNodeWithName("HomeLabel")!.position.y + 25  )
            
        }
        
        if (self.childNodeWithName("StandingsLabel") != nil ) {
            
            
            selectionDict["standings"] = CGPointMake( self.childNodeWithName("StandingsLabel")!.position.x, self.childNodeWithName("StandingsLabel")!.position.y + 25  )
            
        }
        if (self.childNodeWithName("FeaturesLabel") != nil ) {
            
            
            selectionDict["features"] = CGPointMake( self.childNodeWithName("FeaturesLabel")!.position.x, self.childNodeWithName("FeaturesLabel")!.position.y + 25  )
            
        }
        if (self.childNodeWithName("StoreLabel") != nil ) {
            
            
            selectionDict["store"] = CGPointMake( self.childNodeWithName("StoreLabel")!.position.x, self.childNodeWithName("StoreLabel")!.position.y + 25  )
            
        }
        if (self.childNodeWithName("PlayLabel") != nil ) {
            
            
            selectionDict["play"] = CGPointMake( self.childNodeWithName("PlayLabel")!.position.x, self.childNodeWithName("PlayLabel")!.position.y + 25  )
            
        }
        
         if (self.childNodeWithName("Box") != nil ) {
        
            box = self.childNodeWithName("Box") as? SKSpriteNode
            box?.position = selectionDict[selection]!
        
        }
        
        if (currentColor == Colors.Swatch7.rawValue){
            
            inWhiteMode = true
            switchToWhiteMode()
        }
        
        
        
    }
    
    func pressedSelect(){
        
        
        
        if ( transitionInProgress == false) {
            
            transitionInProgress = true
            
            if ( selection == "play"){
                
                print("selected play")
                
                defaults.setInteger(0, forKey: "Team1Score")
                defaults.setInteger(0, forKey: "Team2Score")
                
                let usedCards = [String]()
                defaults.setObject(usedCards, forKey: "UsedCards")
                
                loadGame()
                
            } else if ( selection == "home"){
                
                print("selected home")
                loadHome()
              
            } else if ( selection == "features"){
                
                print("selected features")
                loadFeatures()
                
            }  else if ( selection == "store"){
                
                print("selected store")
                
                transitionInProgress = false
               showStoreAlert()
                
            } else if ( selection == "standings"){
                
                print("selected standings")
                loadStandings()
                
            }
            
            
        }
        
    }
    
    
    
    func swipedRight() {
        
        switch (selection){
            
        case "home":
                selection = "features"
                break
        case "play":
            selection = "standings"
            break
            
            
            
        default:
            break
            
            
        }
        
        let move:SKAction = SKAction.moveTo( selectionDict[selection]! , duration: 0.25)
        move.timingMode = .EaseOut
        box?.runAction(move)
        
    
        
    }
    
    
    func swipedLeft() {
        
       
        switch (selection){
            
        case "features":
            selection = "home"
            break
        case "standings":
            selection = "play"
            break
            
            
            
        default:
            break
            
            
        }
        
        let move:SKAction = SKAction.moveTo( selectionDict[selection]! , duration: 0.25)
        move.timingMode = .EaseOut
        box?.runAction(move)
        
        
        
    }
    
    
    func swipedUp() {
        
        
        switch (selection){
            
        case "standings":
            selection = "features"
            break
        case "play":
            selection = "home"
            break
        case "store":
            selection = "play"
           
            break
            
            
        default:
            break
            
            
        }
        
        let move:SKAction = SKAction.moveTo( selectionDict[selection]! , duration: 0.25)
        move.timingMode = .EaseOut
        box?.runAction(move)
        
        
        
    }
    
    
    func swipedDown() {
        
        switch (selection){
            
        case "features":
            selection = "standings"
            break
        case "home":
            selection = "play"
            break
        case "play":
            selection = "store"
            break
        case "standings":
            selection = "store"
            break
            
            
        default:
            break
            
            
        }
        
        let move:SKAction = SKAction.moveTo( selectionDict[selection]! , duration: 0.25)
        move.timingMode = .EaseOut
        box?.runAction(move)
        
        
        
        
    }
    
    
    
    func loadGame(){
        
        cleanUpScene()
        
        if let scene = GameScene(fileNamed: "GameScene") {
            
            scene.scaleMode = .AspectFill
            
            self.view?.presentScene(scene, transition: SKTransition.fadeWithColor(Helpers.colorFromHexString(currentColor), duration: 2) )
            
        }
        
        
        
    }
    func loadHome(){
        
        cleanUpScene()
        
        if let scene = Home(fileNamed: "Home") {
            
            scene.scaleMode = .AspectFill
            
            self.view?.presentScene(scene, transition: SKTransition.fadeWithColor(Helpers.colorFromHexString(currentColor), duration: 2) )
            
        }
        
        
        
    }
    
    func loadFeatures(){
        
        cleanUpScene()
        
        if let scene = Features(fileNamed: "Features") {
            
            scene.scaleMode = .AspectFill
            
            self.view?.presentScene(scene, transition: SKTransition.fadeWithColor(Helpers.colorFromHexString(currentColor), duration: 2) )
            
        }
        
        
        
    }
    
    func loadStandings(){
        
        cleanUpScene()
        
        if let scene = Standings(fileNamed: "Standings") {
            
            scene.scaleMode = .AspectFill
            
            self.view?.presentScene(scene, transition: SKTransition.fadeWithColor(Helpers.colorFromHexString(currentColor), duration: 2) )
            
        }
        
        
        
    }
    
    
    
    func tappedMenu(){
        
        
        loadHome()
        
        /*
        
        cleanUpScene()
        
        
        if let scene = Home(fileNamed: "Home") {
            
            scene.scaleMode = .AspectFill
            
            self.view?.presentScene(scene, transition: SKTransition.fadeWithColor(SKColor.blackColor(), duration: 2) )
            
        }
        */
        
        
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
    
    
    func showStoreAlert() {
        
        
        
       let playSound:SKAction = SKAction.playSoundFileNamed("selection.caf", waitForCompletion: false)
        self.runAction(playSound)
        
        
        
        let alert:UIAlertController = UIAlertController(title: "Oops", message: "This tutorial really isn't about In-App Purchasing", preferredStyle: UIAlertControllerStyle.Alert)
        
        
        alert.addAction(UIAlertAction(title: "Accept this harsh reality", style: UIAlertActionStyle.Default, handler: { alertAction in
            
            
            print ("do something based on selecting this")
            alert.dismissViewControllerAnimated(true, completion: nil)
            
            
            }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: { alertAction in
            
            
            print ("do something else based on cancelling this")
            alert.dismissViewControllerAnimated(true, completion: nil)
            
            
        }))
        
        let vc:UIViewController = self.view!.window!.rootViewController!
        vc.presentViewController(alert, animated: true, completion:nil)
        
        
    }
    
    
    

}

















