//
//  Color+Extension.swift
//  Wetox-iOS
//
//  Created by Lena on 1/23/24.
//

import UIKit.UIColor

extension UIColor {
    
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
//        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}

extension UIColor {
    
    // MARK: - Profile Colors
    static var profileBackgroundGrayColor: UIColor {
        return UIColor(hexCode: "0xF3F3F3")
    }
    
    static var profileRedColor: UIColor {
        return UIColor(hexCode: "0xFF453A")
    }
    
    static var profileGreenColor: UIColor {
        return UIColor(hexCode: "0x30DB5B")
    }
    
    static var profileOrangeColor: UIColor {
        return UIColor(hexCode: "0xFFB340")
    }
    
    // MARK: - Segmented Control Colors
    static var segmentedBackgroundGrayColor: UIColor {
        return UIColor(hexCode: "0xE8E8E8")
    }
    
    // MARK: - Tint Colors (label / image etc)
    static var unselectedTintColor: UIColor {
        return UIColor(hexCode: "0x404040", alpha: 0.64)
    }
    
    static var selectedTintColor: UIColor {
        return UIColor(hexCode: "0x404040")
    }

}
