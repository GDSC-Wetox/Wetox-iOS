//
//  Button+Extension.swift
//  Wetox-iOS
//
//  Created by 김소현 on 1/24/24.
//

import UIKit.UIButton

extension UIButton {
    
    func createButton(title: String, titleSize: Int, titleColor: UIColor, backgroundColor: UIColor) {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: CGFloat(titleSize), weight: .bold)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
    }
    
    func makeRounded(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
