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
    
    let categoryLabel = UILabel()
    let timeLabel = UILabel()
    private let baseLayer = CALayer() // slider의 track을 그리기 위한 layer
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
        createBaseLayer()
        customizeSlider()
        observeSliderValueChange()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        baseLayer.frame = bounds
        updateTrackImage()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        clear()
    }
    
    private func createBaseLayer() {
        baseLayer.borderWidth = 1
        baseLayer.borderColor = UIColor.clear.cgColor
        baseLayer.masksToBounds = true
        baseLayer.backgroundColor = UIColor.sliderBackgroundGray.cgColor
        baseLayer.cornerRadius = Constants.CornerRadius.slider
        layer.insertSublayer(baseLayer, at: 0)
    }
    
    private func configureUI() {
        minimumValue = Float(Constants.Time.minMinutes)
        maximumValue = Float(Constants.Time.maxMinutes)
        
        backgroundColor = .sliderBackgroundGray
        [categoryLabel, timeLabel].forEach { self.addSubview($0) }
        
        // TODO: text stroke 추가 구현하기
        categoryLabel.setLabel(labelText: "", backgroundColor: .clear, weight: .regular, textSize: 17, labelColor: .white)
        timeLabel.setLabel(labelText: "", backgroundColor: .clear, weight: .light, textSize: 16, labelColor: .unselectedTintColor)
        
        // MARK: label의 autolayout 제약조건
        categoryLabel.snp.makeConstraints {
            $0.leading.equalTo(self).inset(Constants.Padding.defaultPadding)
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
    
    /*
     override var value: Float {
     get {
     return super.value
     }
     set {
     let clampedValue = min(max(Constants.Time.minMinutes, Int(newValue)), Constants.Time.maxMinutes) // Clamp the value between 0 and 1440
     super.value = Float(clampedValue)
     
     print("value changed")
     
     }
     }
     */
    
    
    /// slider를 custom하기 전에 기본 UI 요소를 clear 합니다.
    private func clear() {
        tintColor = .clear
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
        
//        setThumbImage(thumbImage, for: [.normal, .disabled, .focused, .highlighted, .reserved, .selected, .application])
        
        setThumbImage(thumbImage, for: .normal)
        
        // 슬라이더의 코너 라운드 적용
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
    }
    
    
    /*
     
     private func updateMinimumTrackTintColor() {
     let color =  colorForValue(self.value)
     
     UIView.animate(withDuration: 0.5) {
     self.minimumTrackTintColor = color
     }
     }
     */
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
        let trackImage = createTrackImage(color: color)
        setMinimumTrackImage(trackImage?.resizableImage(withCapInsets: .zero), for: .normal)
    }
    
    private func createTrackImage(color: UIColor) -> UIImage? {
        let imageSize = CGSize(width: 1, height: max(baseLayer.frame.height, 44))
        let cornerRadius = Constants.CornerRadius.slider
        
        let renderer = UIGraphicsImageRenderer(size: imageSize)
        
        let trackImage = renderer.image { context in
            let rect = CGRect(origin: .zero, size: imageSize)
            let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
            color.setFill()
            path.fill()
        }
        
        return trackImage
    }
    
    private func colorForValue(_ value: Float) -> UIColor {
//        print("값 관찰: \(value)")
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
}
