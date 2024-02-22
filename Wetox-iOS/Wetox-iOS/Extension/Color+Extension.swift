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
    
    // MARK: - LoginViewController
    static var kakaoTitleColor: UIColor {
        return UIColor(hexCode: "000000")
    }
    
    static var kakaoBackgroundColor: UIColor {
        return UIColor(hexCode: "FEE500")
    }
    
    static var appleTitleColor: UIColor {
        return UIColor(hexCode: "FFFFFF")
    }
    
    static var appleBackgroundColor: UIColor {
        return UIColor(hexCode: "050708")
    }
    
    static var googleTitleColor: UIColor {
        return UIColor(hexCode: "1F1F1F")
    }
    
    static var googleBackgroundColor: UIColor {
        return UIColor(hexCode: "FFFFFF")
    }
    
    static var googleBorderColor: UIColor {
        return UIColor(hexCode: "747775")
    }
    
    // MARK: - ProfileSettingViewController
    static var guidingGrayColor: UIColor {
        return UIColor(hexCode: "818181")
    }
    
    static var blockedButtonColor: UIColor {
        return UIColor(hexCode: "CCCCCC")
    }
    
    static var allowedButtonColor: UIColor {
        return UIColor(hexCode: "30DB5B")
    }
    
    static var checkRedButtonColor: UIColor {
        return UIColor(hexCode: "FF6961")
    }
    
    static var textDeleteButtonColor: UIColor {
        return UIColor(hexCode: "8E8E93")
    }
    
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
        return UIColor(hexCode: "0x404040", alpha: 0.12)
    }
    
    // MARK: - Tint Colors (label / image etc)
    
    /// 404040, alpha: 0.64
    static var unselectedTintColor: UIColor {
        return UIColor(hexCode: "0x404040", alpha: 0.28)
    }
    
    static var selectedTintColor: UIColor {
        return UIColor(hexCode: "0x404040")
    }

    
    // MARK: - ScreenTimeInputview Colors
    static var sliderBackgroundGray: UIColor {
        return UIColor(hexCode: "0xF7F7F7")
    }
    
    // MARK: - TimeLight Colors
    
    /// 3/4 이상 (1080분) 사용 시
    static var wetoxRed: UIColor {
        return UIColor(hexCode: "0xFF453A")
    }
    
    /// 3/4 이하 (1080분) 사용 시
    static var wetoxOrange: UIColor {
        return UIColor(hexCode: "0xFFB340")
    }
    
    /// 2/4 이하 (720분) 사용 시
    static var wetoxYellow: UIColor {
        return UIColor(hexCode: "0xFFD426")
    }
    
    /// 1/4 이하 (360분) 사용 시
    static var wetoxGreen: UIColor {
        return UIColor(hexCode: "0x30DB5B")
    }
    
    // MARK: - AlertTableView Cell Colors
    
    static var greyRejectButton: UIColor {
        return UIColor(hexCode: "D9D9D9", alpha: 0.47)
    }
    
    // MARK: - Common Colors
    
    static var opacityWhite: UIColor {
        return UIColor(hexCode: "0xFFFFFF", alpha: 0.32)
    }
    
    static var strokeGray: UIColor {
        return UIColor(hexCode: "0xC0C0C0")
    }
}
