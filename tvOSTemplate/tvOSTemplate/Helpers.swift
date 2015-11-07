//
//  Helpers.swift
//  tvOSTemplate
//
//  Created by Justin Dike 2 on 10/7/15.
//  Copyright © 2015 CartoonSmart. All rights reserved.
//

import Foundation
import SpriteKit

class Helpers{
    
    
   
   
    
    static func colorFromHexString(rgba:String) -> UIColor {
        
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        
        
        if rgba.hasPrefix("#") {
            
            let hex:String = rgba.stringByReplacingOccurrencesOfString(
                "#",
                withString: "")
            
            
            let scanner = NSScanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexLongLong(&hexValue) {
                
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                
                
            } else {
                
                print("Scan hex error")
                
            }
        } else {
            
            print("Invalid RGB string, missing '#' as prefix")
            
        }
        
        let color:UIColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        
        return color
        
    }
    

    
}