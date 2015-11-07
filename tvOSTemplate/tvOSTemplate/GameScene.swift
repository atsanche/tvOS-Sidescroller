//
//  GameScene.swift
//  tvOSTemplate
//
//  Created by Justin Dike 2 on 10/6/15.
//  Copyright (c) 2015 CartoonSmart. All rights reserved.
//

//
//  Features.swift
//  tvOSTemplate
//
//  Created by Justin Dike 2 on 10/6/15.
//  Copyright © 2015 CartoonSmart. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    
    var whosTurn:Int = 1
    var usedCards = [String]()
    
    var cards = ["AceHearts",
        "AceSpades",
        "AceClubs",
        "AceDiamonds",
        "2Hearts",
        "2Spades",
        "2Clubs",
        "2Diamonds",
        "3Hearts",
        "3Spades",
        "3Clubs",
        "3Diamonds",
        "4Hearts",
        "4Spades",
        "4Clubs",
        "4Diamonds",
        "5Hearts",
        "5Spades",
        "5Clubs",
        "5Diamonds",
        "6Hearts",
        "6Spades",
        "6Clubs",
        "6Diamonds",
        "7Hearts",
        "7Spades",
        "7Clubs",
        "7Diamonds",
        "8Hearts",
        "8Spades",
        "8Clubs",
        "8Diamonds",
        "9Hearts",
        "9Spades",
        "9Clubs",
        "9Diamonds",
        "10Hearts",
        "10Spades",
        "10Clubs",
        "10Diamonds",
        "JackHearts",
        "JackSpades",
        "JackClubs",
        "JackDiamonds",
        "QueenHearts",
        "QueenSpades",
        "QueenClubs",
        "QueenDiamonds",
        "KingHearts",
        "KingSpades",
        "KingClubs",
        "KingDiamonds"]
    
    
    
    let tapGeneralSelection = UITapGestureRecognizer()
    let tapPlayPause = UITapGestureRecognizer()
    
    
    
    var transitionInProgress:Bool = false
    let tapMenu = UITapGestureRecognizer()
    
    var inWhiteMode:Bool = true
    var currentColor:String = Colors.Swatch1.rawValue
    var defaults:NSUserDefaults =  NSUserDefaults.standardUserDefaults()
    
   var cardValueDict = [String: Int]()
    
    var team1Score:Int = 0
    var team2Score:Int = 0
    
    
    override func didMoveToView(view: SKView) {
        
        
        print("In the GameScene class")
        
        
        var i:Int = 1
        var cardValue:Int = 1
        
        
        for card in cards {
            
            if ( i == 5){
                
                i = 1
                cardValue++
            }
            
            
            cardValueDict[card] = cardValue
            
            i++
            
        }
        
        //print(cardValueDict)
        
        
        

        if let usedCardsFromDefaults = defaults.objectForKey("UsedCards") as? [String]{
            
            usedCards = usedCardsFromDefaults
            print(usedCards)
            
        }
        
        if ( defaults.integerForKey("Team1Score") != 0 ) {
            
           team1Score = defaults.integerForKey("Team1Score")
            print ("past score for team 1 was  \( team1Score) ")
            
        }
        if ( defaults.integerForKey("Team2Score") != 0 ) {
            
            team2Score = defaults.integerForKey("Team2Score")
            print ("past score for team 2 was  \( team2Score) ")
            
        }
        
        
        
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
        
        
        tapGeneralSelection.addTarget(self, action: "pressedSelect")
        tapGeneralSelection.allowedPressTypes = [NSNumber (integer:  UIPressType.Select.rawValue)]
        self.view!.addGestureRecognizer(tapGeneralSelection)
        
        
        tapPlayPause.addTarget(self, action: "pressedSelect")
        tapPlayPause.allowedPressTypes = [NSNumber (integer:  UIPressType.PlayPause.rawValue)]
        self.view!.addGestureRecognizer(tapPlayPause)
        
        
        
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
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    
    func pressedSelect(){
        
        if ( self.childNodeWithName("CardLabel") != nil) {
            
            if let label:SKLabelNode = self.childNodeWithName("CardLabel") as? SKLabelNode {
                
                
                var nextCard:String = "used"
                
                
                while (nextCard == "used") {
                    
                    nextCard = returnCard()
                    
                }
                
                
                label.text = nextCard
                
            }
            
            
        }
      

    }
    
    func returnCard() -> String {
        
        print(usedCards.count)
        
        if ( usedCards.count == cards.count){
            
            usedCards.removeAll()
        }
        
        var card:String = ""
        
        let number:UInt32 = arc4random_uniform(  UInt32(cards.count)  )
        card = cards[Int(number)]
        
        
        var cardAlreadyUsed:Bool = false
        
        for usedCard in usedCards {
            
            if (card == usedCard ) {
                cardAlreadyUsed = true
                card = "used"
                break
            }
        }
        
        if (cardAlreadyUsed == false){
            
            usedCards.append(card)
           defaults.setObject(usedCards, forKey: "UsedCards")
            print( "The value is  \( cardValueDict[card] )"  )
            
            if (whosTurn == 1) {
                
                team1Score = team1Score + cardValueDict[card]!
                
                defaults.setInteger(team1Score, forKey: "Team1Score")
                
                whosTurn = 2
                
            } else if (whosTurn == 2) {
                
                
                team2Score = team2Score + cardValueDict[card]!
                
                defaults.setInteger(team2Score, forKey: "Team2Score")
                
                whosTurn = 1
            }
            
            
            
        }

        
        return card
    }
    
    
    
    
    
    
}


