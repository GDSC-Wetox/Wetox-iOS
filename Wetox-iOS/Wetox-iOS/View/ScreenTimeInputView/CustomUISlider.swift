//
//  CustomUISlider.swift
//  Wetox-iOS
//
//  Created by Lena on 1/27/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class CustomUISlider: UISlider {
    
    let categoryLabel = StrokeLabel()
    let timeLabel = UILabel()
    private let trackLayer = CALayer() // slider의 track을 그리기 위한 layer
    private let baseLayer = CALayer() // slider의 base layer
    private var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        configureUI()
        configureTrackLayer()
        customizeSlider()
        observeSliderValueChange()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let point = CGPoint(x: bounds.minX, y: 0)
        return CGRect(origin: point, size: CGSize(width: bounds.width, height: bounds.height))
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        clear()
    }
    
    private func configureUI() {
        updateTrackImage()
        minimumValue = Float(Constants.Time.minMinutes)
        maximumValue = Float(Constants.Time.maxMinutes)
        
        backgroundColor = .sliderBackgroundGray
        
        categoryLabel.setLabel(labelText: "", backgroundColor: .clear, weight: .semibold, textSize: Constants.font.semiTitleSize, labelColor: .white)
        categoryLabel.textAlignment = .center
        timeLabel.setLabel(labelText: "", backgroundColor: .clear, weight: .light, textSize: Constants.font.semiTitleSize, labelColor: .unselectedTintColor)
        
        [categoryLabel, timeLabel].forEach { self.addSubview($0) }
        
        // MARK: label의 autolayout 제약조건
        categoryLabel.snp.makeConstraints {
            $0.leading.equalTo(self).offset(Constants.Padding.defaultPadding)
            $0.centerY.equalTo(self.snp.centerY)
        }
        
        timeLabel.snp.makeConstraints {
            $0.trailing.equalTo(self).inset(Constants.Padding.defaultPadding)
            $0.centerY.equalTo(self.snp.centerY)
        }
        self.snp.makeConstraints {
            $0.height.equalTo(44)
        }
    }
    
    /// slider를 custom하기 전에 기본 UI 요소를 clear 합니다.
    private func clear() {
        tintColor = .clear
        minimumTrackTintColor = .clear
        maximumTrackTintColor = .clear
        backgroundColor = .clear
        thumbTintColor = .clear
    }
    
    private func updateLabel() {
        timeLabel.text = "\(Int(self.value))분"
    }
    
    private func customizeSlider() {
        
        // thumbImage 세팅
        let thumbImage = UIImage(named: Constants.Image.sliderTrackImageName)
        setThumbImage(thumbImage, for: [.normal, .disabled, .focused, .highlighted, .reserved, .selected, .application])
        
        // 슬라이더의 코너 라운드 적용
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
    }
    
    /// UISlider의 값에 따라 레이블 및 색상이 변경되도록 합니다
    private func observeSliderValueChange() {
        rx.value.asObservable()
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] value in
                self?.updateLabel()
                self?.updateTrackImage()
            })
            .disposed(by: disposeBag)
    }
    
    private func updateTrackImage() {
        let color = colorForValue(self.value)
        minimumTrackTintColor = color
        
        let thumbRect = thumbRect(forBounds: bounds, 
                                  trackRect: trackRect(forBounds: bounds),
                                  value: value)
        
        trackLayer.frame = .init(x: 0,
                                 y: frame.height / 4,
                                 width: thumbRect.midX,
                                 height: frame.height / 2)
    }

    /// 입력하는 값에 따라 minimumTrack의 색상을 변경합니다
    private func colorForValue(_ value: Float) -> UIColor {
        let maxValue = Float(Constants.Time.maxMinutes)
        let minValue = Float(Constants.Time.minMinutes)
        let colorStep = Float(maxValue / 4)
        
        switch value {
            case minValue..<colorStep:
                return .wetoxGreen
            case colorStep..<(2 * colorStep):
                return .wetoxYellow
            case (2 * colorStep)..<(3 * colorStep):
                return .wetoxOrange
            default:
                return .wetoxRed
        }
    }
    
    private func configureTrackLayer() {
        trackLayer.frame = .init(x: 0, y: frame.height, width: 0, height: frame.height / 2)
        trackLayer.cornerRadius = 12
        layer.insertSublayer(trackLayer, at: 1)
    }
}
