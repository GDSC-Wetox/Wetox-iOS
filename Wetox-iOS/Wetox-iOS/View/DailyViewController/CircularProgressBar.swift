//
//  CircularProgressBar.swift
//  Wetox-iOS
//
//  Created by Lena on 1/23/24.
//

import UIKit
import SnapKit

class CircularProgressBar: UIView {
    
    var lineWidth: CGFloat = 5
    
    /// progressBar 내부에 들어갈 profileImage의 크기 설정을 위한 비율
    let cornerRadiusRatio: CGFloat = 0.8
    /// progressBar의 크기 설정을 위한 비율
    let cornerRadiusProgressRatio: CGFloat = 0.85
    
    /// 해당 value 값이 변경되면 progress bar 갱신
    var value: Double? {
        didSet {
            guard let _ = value else { return }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// progressBar의 전체 원형 그리는 부분
    override func draw(_ rect: CGRect) {
        let bezierPath = UIBezierPath()
        bezierPath.addArc(withCenter: CGPoint(x: rect.midX, y: rect.midY),
                          radius: cornerRadiusProgressRatio * (rect.midX - (lineWidth / 2)),
                          startAngle: 0,
                          endAngle: .pi * 2,
                          clockwise: true)
        bezierPath.lineWidth = 4
        UIColor.profileBackgroundGrayColor.set() // 남아있는 시간의 색상
        bezierPath.stroke()
    }
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    func setProgress(_ rect: CGRect) {
        guard let value = self.value else {
            return
        }
        
        // TableView나 CollectionView에서 재생성 될때 계속 추가되는 것을 막기 위해 제거
        self.subviews.forEach { $0.removeFromSuperview() }
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }

        let bezierPath = UIBezierPath()
        bezierPath.addArc(withCenter: CGPoint(x: rect.midX, y: rect.midY),
                          radius: cornerRadiusProgressRatio * (rect.midX - (lineWidth / 2)),
                          startAngle: -.pi / 2,
                          endAngle: ((.pi * 2) * value) - (.pi / 2),
                          clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.lineCap = .round    // 프로그래스 바의 끝을 둥글게 설정
        
        let color: UIColor = .profileGreenColor
        
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = lineWidth
        
        self.layer.addSublayer(shapeLayer)
        let imageSize = (rect.midX - (lineWidth / 2)) * cornerRadiusRatio * 1.96
        profileImageView.layer.cornerRadius = imageSize / 2
        setupProfileImageView()
        profileImageView.snp.makeConstraints {
//            $0.center.equalTo(self.snp.center)
            $0.width.height.equalTo(imageSize)
        }
    }
    
    private func setupProfileImageView() {
        profileImageView.backgroundColor = .clear
        profileImageView.tintColor = .clear
        profileImageView.contentMode = .center
        profileImageView.layer.masksToBounds = true
        profileImageView.clipsToBounds = true
//        profileImageView.contentMode = .scaleAspectFit
        self.addSubview(profileImageView)
        profileImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
