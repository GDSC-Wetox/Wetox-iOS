//
//  BottomSheetView.swift
//  Wetox-iOS
//
//  Created by Lena on 1/28/24.
//

import UIKit
import SnapKit

class BottomSheetView: UIView {
    
    private let titleLabel = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        self.layer.cornerRadius = Constants.CornerRadius.slider
        titleLabel.setLabel(labelText: Constants.Text.bottomSheetTitle, backgroundColor: .clear, weight: .regular, textSize: Constants.font.semiTitleSize, labelColor: .black)
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.center.equalTo(self.snp.center)
            
        }
        self.backgroundColor = .white
        self.customShadow(color: .lightGray, width: 0, height: -3, opacity: 0.3, radius: 25)
        
    }
}
