//
//  StrokeLabel.swift
//  Wetox-iOS
//
//  Created by Lena on 1/28/24.
//

import UIKit

class StrokeLabel: UILabel {
    
    var strokeSize: CGFloat = 4
    var strokeColor: UIColor = .strokeGray
    var additionalWidth: CGFloat = 4.0
    
    override func drawText(in rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let textColor = self.textColor
        context?.setLineWidth(self.strokeSize)
        context?.setLineJoin(CGLineJoin.miter)
        context?.setTextDrawingMode(CGTextDrawingMode.stroke)
        self.textColor = self.strokeColor
        super.drawText(in: rect)
        context?.setTextDrawingMode(.fill)
        self.textColor = textColor
        super.drawText(in: rect)
    }
    
    override var intrinsicContentSize: CGSize {
        let originalContentSize = super.intrinsicContentSize
        let widthWithPadding = originalContentSize.width + additionalWidth
        return CGSize(width: widthWithPadding, height: originalContentSize.height)
    }
}
