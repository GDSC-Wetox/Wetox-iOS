//
//  LoginViewController.swift
//  Wetox-iOS
//
//  Created by 김소현 on 1/24/24.
//

import UIKit
import SnapKit

import KakaoSDKUser
import KakaoSDKAuth
import AuthenticationServices

class LoginViewController: UIViewController {
    
    var subTitleLabel: UILabel = UILabel()
    var titleLabel: UILabel = UILabel()
    
    var kakaoLoginButton: UIButton = UIButton()
    var appleLoginButton: UIButton = UIButton()
    var googleLoginButton: UIButton = UIButton()
    
    var guidingBoldLabel: UILabel = UILabel()
    var guidingLightLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        [subTitleLabel, titleLabel, kakaoLoginButton, appleLoginButton, googleLoginButton, guidingBoldLabel, guidingLightLabel].forEach { view.addSubview($0) }
        
        kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginButtonTapped), for: .touchUpInside)
        
        setupLabelLayout()
        setupButtonLayout()
        configureLayout()
    }
    
    private func setupLabelLayout() {
        
        subTitleLabel.setLabel(labelText: "우리의 Detox Mate",
                               backgroundColor: .clear,
                               weight: .light,
                               textSize: 18,
                               labelColor: .black)
        
        titleLabel.setLabel(labelText: "Wetox",
                            backgroundColor: .clear,
                            weight: .medium,
                            textSize: 35,
                            labelColor: .black)
        
        guidingBoldLabel.setLabel(labelText: "가입하면",
                                  backgroundColor: .clear,
                                  weight: .medium,
                                  textSize: 12,
                                  labelColor: .gray)
        
        guidingLightLabel.numberOfLines = 2
        guidingLightLabel.setLabel(labelText: "⋅ 나의 스크린타임을 친구와 공유할 수 있습니다\n⋅ 개인 맞춤형 성과 달성에 따른 배지를 획득할 수 있습니다",
                                   backgroundColor: .clear,
                                   weight: .ultraLight,
                                   textSize: 12,
                                   labelColor: .gray)
    }
    
    private func setupButtonLayout() {
        // TODO: image 추가하기
        
        kakaoLoginButton.setRooundedButton(title: "카카오 계정으로 계속하기",
                                           titleSize: 14,
                                           titleColor: UIColor.kakaoTitleColor,
                                           backgroundColor: UIColor.kakaoBackgroundColor,
                                           radius: 9)
        
        appleLoginButton.setRooundedButton(title: "애플 계정으로 계속하기",
                                           titleSize: 14,
                                           titleColor: UIColor.appleTitleColor,
                                           backgroundColor: UIColor.appleBackgroundColor,
                                           radius: 9)
        
        googleLoginButton.setRooundedButton(title: "구글 계정으로 계속하기",
                                            titleSize: 14,
                                            titleColor: UIColor.googleTitleColor,
                                            backgroundColor: UIColor.googleBackgroundColor,
                                            radius: 9)
        
        googleLoginButton.layer.borderWidth = 1
        googleLoginButton.layer.borderColor = UIColor.googleBorderColor.cgColor
    }
    
    private func configureLayout() {
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(138)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(162)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(510)
            make.leading.trailing.equalToSuperview().inset(24)
            make.width.equalTo(323)
            make.height.equalTo(49)
        }
        
        appleLoginButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(568)
            make.leading.trailing.equalToSuperview().inset(24)
            make.width.equalTo(323)
            make.height.equalTo(49)
        }
        
        googleLoginButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(626)
            make.leading.trailing.equalToSuperview().inset(24)
            make.width.equalTo(323)
            make.height.equalTo(49)
        }
        
        guidingBoldLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(702)
            make.leading.trailing.equalToSuperview().inset(36)
        }
        
        guidingLightLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(715)
            make.leading.trailing.equalToSuperview().inset(36)
        }
    }
    
    @objc func kakaoLoginButtonTapped() {
        print("tapped")
        
    }
}
