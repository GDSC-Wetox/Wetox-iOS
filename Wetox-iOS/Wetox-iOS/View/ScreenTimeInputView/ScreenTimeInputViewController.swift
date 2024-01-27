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
     - 네비게이션 바 타이틀, done 버튼
     - 스크린타임 확인하는 안내문 <-> 오류 생기는 경우 레이블
     - CustomUISlider 만들어서 재사용할 수 있도록
     - 입력받는 모델 구현
     */
    
    var sliders: [CustomUISlider] = []
    private let infoTitleLabel = UILabel()
    private let infoContentLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNavigation()
        [infoTitleLabel, infoContentLabel].forEach { view.addSubview($0) }
        
        for _ in 0..<Constants.Category.categories.count {
            let slider = CustomUISlider()
            view.addSubview(slider)
            sliders.append(slider)
        }
        
        customizeLabel()
        configureLayout()
    }
    
    private func setNavigation() {
        self.title = Constants.ScreenTimeInput.navigationTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.Common.doneText, style: .done, target: self, action: #selector(doneAction))
        
    }
    
    private func customizeLabel() {
        infoTitleLabel.setLabel(labelText: Constants.ScreenTimeInput.titleMessage, backgroundColor: .clear, weight: .semibold, textSize: Constants.font.semiTitleSize, labelColor: .lightGray)
        infoContentLabel.setLabel(labelText: Constants.ScreenTimeInput.infoMessage, backgroundColor: .clear, weight: .medium, textSize: Constants.font.contentSize, labelColor: .darkGray)
        infoContentLabel.numberOfLines = 0
    }
    
    private func configureLayout() {
        
        infoTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Constants.Padding.defaultPadding)
            $0.leading.trailing.equalTo(view).inset(Constants.Padding.defaultPadding)
        }
        infoContentLabel.snp.makeConstraints {
            $0.top.equalTo(infoTitleLabel.snp.bottom)
            $0.leading.trailing.equalTo(view).inset(Constants.Padding.defaultPadding)
        }
        
        var previousSlider: UIView = infoContentLabel
        
        for slider in sliders {
            slider.snp.makeConstraints {
                $0.top.equalTo(previousSlider.snp.bottom).offset(14)
                $0.leading.trailing.equalTo(view).inset(Constants.Padding.defaultPadding)
            }
            previousSlider = slider
        }
        
        
    }
    
    @objc func doneAction() {
        // 완료 버튼을 눌렀을 때의 액션을 여기에 구현하세요.
        print("ScreenTimeInputView에서 done 버튼을 눌렀습니다. ")
    }
}
