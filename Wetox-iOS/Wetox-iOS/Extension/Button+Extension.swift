//
//  Button+Extension.swift
//  Wetox-iOS
//
//  Created by 김소현 on 1/24/24.
//

import UIKit.UIButton

extension UIButton {
    
    func setButton(title: String, titleSize: Int, titleColor: UIColor, backgroundColor: UIColor) {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: CGFloat(titleSize), weight: .bold)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
    }
    
    func setRooundedButton(title: String, titleSize: Int, titleColor: UIColor, backgroundColor: UIColor, radius: CGFloat) {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: CGFloat(titleSize), weight: .bold)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
