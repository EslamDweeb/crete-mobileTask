//
//  UIColor_Ext.swift
//  Leedo
//
//  Created by eslam dweeb on 21/09/2022.
//

import UIKit
extension UIColor {
    
    static let gradiantOrange:UIColor = .init(hex: "#EB8855")
   
    
    
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if hexString.hasPrefix("#") {
            scanner.currentIndex = hex.index(after: hexString.startIndex)
        }
        
        var hexValue: UInt64 = 0
        if scanner.scanHexInt64(&hexValue) {
            let red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
            let blue = CGFloat(hexValue & 0x0000FF) / 255.0
            
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        } else {
            fatalError("Invalid hex string: \(hexString)")
        }
    }
}
