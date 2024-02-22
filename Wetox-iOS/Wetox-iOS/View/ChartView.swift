//
//  ChartView.swift
//  Wetox-iOS
//
//  Created by Lena on 2/22/24.
//

import UIKit
import SnapKit

/// Dummy UIView
// TODO: 22일 제출 후 재구현 예정
class ChartView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureLayout()
    }
    
    private let chartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "temp-view")
        
        return imageView
    }()
    
    private func configureLayout() {
        addSubview(chartImageView)
        
        chartImageView.snp.makeConstraints {
            $0.leading.top.trailing.bottom.equalToSuperview()
            $0.width.height.equalTo(340)
        }
    }
}
