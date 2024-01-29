//
//  View+Extension.swift
//  Wetox-iOS
//
//  Created by Lena on 1/28/24.
//

import UIKit

extension UIView {
    
    // TODO: dynamic shadow는 성능문제 있다는 warning 메세지 발생 해결하기
    func customShadow(color: UIColor, width: Int, height: Int, opacity: Float, radius: CGFloat) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false
    }
    
    /*
    func customShadow(color: UIColor, width: Int, height: Int, opacity: Float, radius: CGFloat) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false
        
        self.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: width, height: height)).cgPath
    }
     */
}
