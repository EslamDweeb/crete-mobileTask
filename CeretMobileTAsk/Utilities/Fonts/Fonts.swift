//
//  Fonts.swift
//  Jarvis
//
//  Created by eslam dweeb on 30/05/2022.
//


import UIKit
class Fonts {
     enum FontName:String {
        case Montserrat
        case Poppins
    }
    private enum FontWeight {
        case Regular(String)
        case Light(String)
        case Bold(String)
        case SemiBold(String)
        case Medium(String)
    }
    
    private static func customFont(font: FontWeight, size: CGFloat) -> UIFont {
        let fontName: String
        
        switch font {
        case .Regular(let name):
            fontName = name + "-Regular" // 400
        case .Light(let name):
            fontName = name + "-Light" // 300
        case .Bold(let name):
            fontName = name + "-Bold" // 700
        case .SemiBold(let name):
            fontName = name + "-SemiBold" // 600
        case .Medium(let name):
            fontName = name + "-Medium" // 500
        }
        
        guard let customFont = UIFont(name: fontName, size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return UIFontMetrics.default.scaledFont(for: customFont)
    }
    
    static func regular(name: String, size: CGFloat) -> UIFont {
        return customFont(font: .Regular(name), size: size)
    }
    
    static func light(name: String, size: CGFloat) -> UIFont {
        return customFont(font: .Light(name), size: size)
    }
    
    static func bold(name: String, size: CGFloat) -> UIFont {
        return customFont(font: .Bold(name), size: size)
    }
    
    static func semiBold(name: String, size: CGFloat) -> UIFont {
        return customFont(font: .SemiBold(name), size: size)
    }
    
    static func medium(name: String, size: CGFloat) -> UIFont {
        return customFont(font: .Medium(name), size: size)
    }
    
}
class FontSize {
    static let fontTiny : CGFloat = 8
    static let fontSmall : CGFloat = 11
    static let fontRegular : CGFloat = 14
    static let fontMedium : CGFloat = 16
    static let fontSmiLarg : CGFloat = 18
    static let fontLarge : CGFloat = 20
    static let fontTwintyTwo: CGFloat = 22
    static let fontTwintyFour: CGFloat = 24
    static let fontVeryLarge : CGFloat = 28
    static let fontThirty: CGFloat = 30
    static let fontThirtyFour:CGFloat = 34
    static let sizeFifteen:CGFloat = 15
}
