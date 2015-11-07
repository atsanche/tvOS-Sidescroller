//
//  Features.swift
//  tvOSTemplate
//
//  Created by Justin Dike 2 on 10/6/15.
//  Copyright © 2015 CartoonSmart. All rights reserved.
//

import SpriteKit

class Standings: SKScene {
    
    
    var transitionInProgress:Bool = false
    let tapMenu = UITapGestureRecognizer()
    
    var inWhiteMode:Bool = true
    var currentColor:String = Colors.Swatch1.rawValue
    var defaults:NSUserDefaults =  NSUserDefaults.standardUserDefaults()
    
    var team1Score:Int = 0
    var team2Score:Int = 0
    
    override func didMoveToView(view: SKView) {
        
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
        
        if (currentColor == Colors.Swatch7.rawValue){
            
            inWhiteMode = true
            switchToWhiteMode()
        }
        
        
        
        
        
        if ( defaults.integerForKey("Team1Score") != 0 ) {
            
            team1Score = defaults.integerForKey("Team1Score")
            print ("past score for team 1 was  \( team1Score) ")
            
        }
        if ( defaults.integerForKey("Team2Score") != 0 ) {
            
            team2Score = defaults.integerForKey("Team2Score")
            print ("past score for team 2 was  \( team2Score) ")
            
        }
        
        
        if ( self.childNodeWithName("Team1Label") != nil) {
            
            if let team1Label:SKLabelNode = self.childNodeWithName("Team1Label") as? SKLabelNode {
                
                team1Label.text = String(team1Score)
                team1Label.fontColor = SKColor.blueColor()
            }
            
            
        }
        
        if ( self.childNodeWithName("Team2Label") != nil) {
            
            if let team2Label:SKLabelNode = self.childNodeWithName("Team2Label") as? SKLabelNode {
                
                team2Label.text = String(team2Score)
                 team2Label.fontColor = SKColor.redColor()
                
            }
            
            
        }

        
        
        
    }
    
    
    func tappedMenu(){
        
        
        cleanUpScene()
        
        
        if let scene = Home(fileNamed: "Home") {
            
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
    
    
    func switchToWhiteMode(){
        
        if (inWhiteMode == true){
            
            for node in self.children {
                
                if let text = node as? SKLabelNode {
                    
                    text.fontColor = SKColor.grayColor()
                    
                }
                
                
            }
            
            
        }
        
        
        
    }
    
}