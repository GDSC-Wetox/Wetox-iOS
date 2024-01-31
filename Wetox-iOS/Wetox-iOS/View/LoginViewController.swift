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
    
    private let subTitleLabel: UILabel = UILabel()
    private let titleLabel: UILabel = UILabel()
    
    var kakaoLoginButton: UIButton = UIButton()
    var appleLoginButton: UIButton = UIButton()
    var googleLoginButton: UIButton = UIButton()
    
    private let guidingBoldLabel: UILabel = UILabel()
    private let guidingLightLabel: UILabel = UILabel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let isLogin = UserDefaults.standard.bool(forKey: Const.UserDefaultsKey.isLogin)
        let accessToken = UserDefaults.standard.string(forKey: Const.UserDefaultsKey.accessToken)
        
        if isLogin && accessToken != nil {
            self.navigationController?.pushViewController(MainViewController(), animated: true)
        }
    }
    
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
        let openId = UserDefaults.standard.string(forKey: Const.UserDefaultsKey.openId)
        let oauthProvider = UserDefaults.standard.string(forKey: Const.UserDefaultsKey.oauthProvider)
        
        // 카카오 로그인 요청 시 사용할 수 있는 추가 기능 for openid
        UserApi.shared.me() { (user, error) in
            if let error = error {
                print(error)
            }
            else {
                if user != nil {
                    var scopes = [String]()
                    scopes.append("openid")
                    
                    if scopes.count > 0 {
                        print("사용자에게 추가 동의를 받아야 합니다.")
                        
                        // scope 목록을 전달하여 카카오 로그인 요청
                        UserApi.shared.loginWithKakaoAccount(scopes: scopes) { (_, error) in
                            if let error = error {
                                print(error)
                            }
                            else {
                                UserApi.shared.me() { (user, error) in
                                    if let error = error {
                                        print(error)
                                    }
                                    else {
                                        print("me() success.")
                                        _ = user
                                        print(user!)
                                    }
                                }
                            }
                        }
                    }
                    else {
                        print("사용자의 추가 동의가 필요하지 않습니다.")
                    }
                }
            }
        }
        
        // 카카오톡 어플 실행 가능 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    UserDefaults.standard.set(oauthToken!.accessToken, 
                                              forKey: Const.UserDefaultsKey.accessToken)
                    
                    if openId != nil && oauthProvider == "카카오" {
                        // 로그인 API
                        print("UserDefaults의 sessionId로 로그인을 시도합니다")
                        self.loginWithAPI(loginRequest: LoginRequest(oauthProvider: "카카오", openId: openId!))
                        self.navigationController?.pushViewController(MainViewController(), animated: true)
                    } else {
                        // 회원가입 API
                        self.socialSignUp(accessToken: UserDefaults.standard.string(forKey: Const.UserDefaultsKey.accessToken) ?? "")
                    }
                }
            }
        }
        
        // 카카오 계정으로 로그인
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    UserDefaults.standard.set(oauthToken!.accessToken,
                                              forKey: Const.UserDefaultsKey.accessToken)
  
                    if openId != nil && oauthProvider == "카카오" {
                        // 로그인 API
                        print("UserDefaults의 sessionId로 로그인을 시도합니다")
                        self.loginWithAPI(loginRequest: LoginRequest(oauthProvider: "카카오", openId: openId!))
                        self.navigationController?.pushViewController(MainViewController(), animated: true)
                    } else {
                        // 회원가입 API
                        self.socialSignUp(accessToken: UserDefaults.standard.string(forKey: Const.UserDefaultsKey.accessToken) ?? "")
                    }
                }
            }
    }
    
    func socialSignUp(accessToken: String) {
        print("회원가입을 진행합니다.")
        print(accessToken)
        var profileSettingViewContorller = ProfileSettingViewContorller()
        profileSettingViewContorller.accessToken = UserDefaults.standard.string(forKey: Const.UserDefaultsKey.accessToken) ?? ""
        // TODO: push가 안되는 오류
        self.navigationController?.pushViewController(profileSettingViewContorller, animated: true)
    }
}

extension LoginViewController {
    func loginWithAPI(loginRequest: LoginRequest) {
        AuthAPI.shared.login(loginRequest: loginRequest) { response in
            switch response {
            case .success(let loginData):
                if let data = loginData as? LoginResponse {
                    UserDefaults.standard.set(loginRequest.oauthProvider, forKey: Const.UserDefaultsKey.oauthProvider)
                    UserDefaults.standard.set(data.accessToken, forKey: Const.UserDefaultsKey.accessToken)
                    UserDefaults.standard.set(Date(), forKey: Const.UserDefaultsKey.updatedAt)
                    UserDefaults.standard.set(true, forKey: Const.UserDefaultsKey.isLogin)
                }
            case .requestError(let resultCode, let message):
                print("loginWithAPI - requestError: [\(resultCode)] \(message)")
            case .pathError:
                print("loginWithAPI - pathError")
            case .serverError:
                print("loginWithAPI - serverError")
            case .networkFail:
                print("loginWithAPI - networkFail")
            }
        }
    }
}

