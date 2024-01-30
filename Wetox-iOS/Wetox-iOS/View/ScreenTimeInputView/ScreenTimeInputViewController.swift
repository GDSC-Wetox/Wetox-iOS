//
//  ScreenTimeInputViewController.swift
//  Wetox-iOS
//
//  Created by Lena on 1/27/24.
//

import UIKit

import SnapKit
import RxSwift

class ScreenTimeInputViewController: UIViewController {
    
    /*
     - 스크린타임 확인하는 안내문 <-> 오류 생기는 경우 레이블
     - CustomUISlider 만들어서 재사용할 수 있도록
     - 입력받는 모델 구현
     */
    
    var sliders: [CustomUISlider] = []
    let categories = Constants.Category.categories
    private let infoTitleLabel = UILabel()
    private let infoContentLabel = UILabel()
    
    private var sliderValueObservables: [Observable<Float>] = []
    private var screenTimeInputViewModel: ScreenTimeInputViewModel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        [infoTitleLabel, infoContentLabel].forEach { view.addSubview($0) }
        
        for i in 0..<categories.count {
            let slider = CustomUISlider()
            slider.categoryLabel.text = categories[i]
            view.addSubview(slider)
            sliders.append(slider)
        }
        
        sliderValueObservables = sliders.map { $0.rx.value.asObservable() }
        screenTimeInputViewModel = ScreenTimeInputViewModel(sliderValues: sliderValueObservables)
        
        customizeLabel()
        configureLayout()
        bind()
        configureNavigation()
    }

    private func customizeLabel() {
        
        infoTitleLabel.setLabel(labelText: Constants.ScreenTimeInput.titleMessage, backgroundColor: .clear, weight: .semibold, textSize: Constants.font.semiTitleSize, labelColor: .lightGray)
        
        infoContentLabel.setLabel(labelText: Constants.ScreenTimeInput.infoMessage, backgroundColor: .clear, weight: .medium, textSize: Constants.font.contentSize, labelColor: .darkGray)
        
        infoContentLabel.numberOfLines = 0
    }
    
    private func configureNavigation() {
        title = "스크린타임 입력하기"
        
        // TODO: 데이터 저장 및 메인에 적용 구현
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissViewController))
    }
    
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
    
    private func configureLayout() {
        
        infoTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalTo(view).inset(Constants.Padding.defaultPadding)
        }
        
        infoContentLabel.snp.makeConstraints {
            $0.top.equalTo(infoTitleLabel.snp.bottom)
            $0.leading.trailing.equalTo(view).inset(Constants.Padding.defaultPadding)
        }
        
        var previousSlider: UIView = infoContentLabel
        
        for slider in sliders {
            slider.snp.makeConstraints {
                $0.top.equalTo(previousSlider.snp.bottom).offset(Constants.Padding.narrowPadding)
                $0.leading.trailing.equalTo(view).inset(Constants.Padding.defaultPadding)
            }
            previousSlider = slider
        }
    }
    
    private func bind() {
        screenTimeInputViewModel.totalSliderValue
            .subscribe(onNext: { [weak self] totalValue in
                if Int(totalValue) > Constants.Time.maxMinutes {
                    self?.infoTitleLabel.text = Constants.ScreenTimeInput.timeoverTitleMessage
                    self?.infoContentLabel.text = Constants.ScreenTimeInput.timeoverInfoMessage
                } else {
                    self?.infoTitleLabel.text = Constants.ScreenTimeInput.titleMessage
                    self?.infoContentLabel.text = Constants.ScreenTimeInput.infoMessage
                }
            })
            .disposed(by: disposeBag)
    }
}
