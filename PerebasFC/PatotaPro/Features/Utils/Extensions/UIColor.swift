//
//  UIColor.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 03/06/23.
//

import UIKit

extension UIColor {
    static let gold = UIColor(red: 218/255, green: 162/255, blue: 32/255, alpha: 1.0)
    static let silver = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1.0)
    static let browned = UIColor(red: 148/255, green: 93/255, blue: 65/255, alpha: 1.0)
}

extension UIColor {
   
    static func contrastRatio(between color1: UIColor, and color2: UIColor) -> CGFloat {
        let luminance1 = color1.luminance()
        let luminance2 = color2.luminance()
        
        let luminanceDarker = min(luminance1, luminance2)
        let luminanceLighter = max(luminance1, luminance2)
        
        return (luminanceLighter + 0.05) / (luminanceDarker + 0.05)
    }
    
    func contrastRatio(with color: UIColor) -> CGFloat {
        return UIColor.contrastRatio(between: self, and: color)
    }
    
    func luminance() -> CGFloat {
        let ciColor = CIColor(color: self)
        
        func adjust(colorComponent: CGFloat) -> CGFloat {
            return (colorComponent < 0.04045) ? (colorComponent / 12.92) : pow((colorComponent + 0.055) / 1.055, 2.4)
        }
        
        return 0.2126 * adjust(colorComponent: ciColor.red) + 0.7152 * adjust(colorComponent: ciColor.green) + 0.0722 * adjust(colorComponent: ciColor.blue)
    }

}
