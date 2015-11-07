//
//  Features.swift
//  tvOSTemplate
//
//  Created by Justin Dike 2 on 10/6/15.
//  Copyright © 2015 CartoonSmart. All rights reserved.
//

import SpriteKit

class Features: SKScene {
    
    
    var transitionInProgress:Bool = false
    let tapMenu = UITapGestureRecognizer()
    
    var inWhiteMode:Bool = true
    var currentColor:String = Colors.Swatch1.rawValue
    var defaults:NSUserDefaults =  NSUserDefaults.standardUserDefaults()
    
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