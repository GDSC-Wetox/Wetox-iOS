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
                                        print(user)
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
                    print("loginWithKakaoTalk() success.")

                    //do something
                    _ = oauthToken
                    
                    self.socialSignUp(accessToken: oauthToken!.accessToken)
                    
                }
            }
        }
        
        // 카카오 계정으로 로그인
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    _ = oauthToken
                    print("this is oauthToken \(oauthToken!)")
                    
                    self.socialSignUp(accessToken: oauthToken?.accessToken ?? "")
                }
            }
    }
    
    func socialSignUp(accessToken: String) {
        let profileSettingViewContorller = ProfileSettingViewContorller()
        profileSettingViewContorller.accessToken = UserDefaults.standard.string(forKey: "") ?? ""
        self.navigationController?.pushViewController(profileSettingViewContorller, animated: true)
    }
}

/*
 
 loginWithKakaoAccount() success.
 
 // 카카오로부터 응답으로 받은 oauthToken 내용
 
 OAuthToken(
 tokenType: "bearer",
 accessToken: "6tJO9FBb-d2z-niI0mSZHfW4UOWx3HAYhLMKKwynAAABjUCOugL7Ewsnpgvovw",
 expiresIn: 43199.0,
 expiredAt: 2024-01-26 00:18:31 +0000,
 refreshToken: "VipufcYGxxoISgnwSboYu7WiaNjybO1Jx-QKKwynAAABjUCOuf_7Ewsnpgvovw",
 refreshTokenExpiresIn: 5183999.0,
 refreshTokenExpiredAt: 2024-03-25 12:18:31 +0000,
 scope: Optional("openid"),
 scopes: Optional(["openid"]),
 idToken: Optional("eyJraWQiOiI5ZjI1MmRhZGQ1ZjIzM2Y5M2QyZmE1MjhkMTJmZWEiLCJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJiYWZlMDZmYWUxOGEzOGFkNDlhZDYyYWM0MDdkMjg1ZiIsInN1YiI6IjMzMDE4MzUxNDMiLCJhdXRoX3RpbWUiOjE3MDYxODUxMTIsImlzcyI6Imh0dHBzOi8va2F1dGgua2FrYW8uY29tIiwiZXhwIjoxNzA2MjI4MzEyLCJpYXQiOjE3MDYxODUxMTJ9.S83myeppnJ3VLFvi3oISMVZCjxmqS7Qr6lblXCqyVATglHab65p47ZouvI_LZmEHM2URez3T74ts2dd20kipJceQuiK27zrfabt_jv99yRtqtHRqG9TL71lEpOuFQGEGAKbrkXtc2XBwlb8eqW-yanPPoB6K6FOuFzKTqe-HMRbyH4eWAhQMeEswzjJGaH405aP5Ee27Fl764bzcFInOkN_2r-QYSXhrpYBM-S2b3Qm6coCvwSaiSHdIEE9R_OINIDPtgEO_BYeCz5swuCpecXtOOOcEqRLzBTEM4Sx5o8K3CQAsCHNlBpU-vAx8lI_6I0kGt2J8XH4axdcf0j4SHg")
 )
 
 */
