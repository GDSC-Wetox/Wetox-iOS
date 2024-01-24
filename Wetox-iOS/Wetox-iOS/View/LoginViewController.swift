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
                                           titleColor: UIColor(hexCode: "000000"),
                                           backgroundColor: UIColor(hexCode: "FEE500"),
                                           radius: 9)
        
        appleLoginButton.setRooundedButton(title: "애플 계정으로 계속하기",
                                           titleSize: 14,
                                           titleColor: UIColor(hexCode: "FFFFFF"),
                                           backgroundColor: UIColor(hexCode: "050708"),
                                           radius: 9)
        
        googleLoginButton.setRooundedButton(title: "구글 계정으로 계속하기",
                                           titleSize: 14,
                                           titleColor: UIColor(hexCode: "1F1F1F"),
                                           backgroundColor: UIColor(hexCode: "FFFFFF"),
                                           radius: 9)
        
        googleLoginButton.layer.borderWidth = 1
        googleLoginButton.layer.borderColor = UIColor(hexCode: "747775").cgColor
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
        
//        if UserApi.isKakaoTalkLoginAvailable() { // 카카오톡으로 로그인
//            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
//                if let error = error {
//                    print(error)
//                } else {
//                    // 회원가입 API
//                        // self.socialSignUp(accessToken: "bafe06fae18a38ad49ad62ac407d285f")
//                    }
//                }
//            } else { // 카카오 계정으로 로그인
//            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
//                if let error = error {
//                    print(error)
//                } else {
//                        self.loginWithAPI(loginRequest: LoginRequest(token: oauthToken!.accessToken, socialType: "카카오"))
//                        self.navigationController?.pushViewController(TabBarController(), animated: true)
//                    } else { // sessionId가 존재하지 않음 > 회원가입 API
//                        UserDefaults.standard.set(oauthToken!.accessToken, forKey: Const.UserDefaultsKey.accessToken)
//                        self.socialSignUp(accessToken: UserDefaults.standard.string(forKey: Const.UserDefaultsKey.accessToken) ?? "")
//                    }
//                }
//            }
        }
    
//    func requestKakaoUserProfile() {
//        // 카카오 사용자 정보 요청
//        UserApi.shared.me() { [weak self] (user, error) in
//            if let error = error {
//                print(error)
//            } else {
//                if let user = user {
//                    // 카카오 사용자 정보를 사용하여 로그인 성공 후의 동작을 구현
//                    print("Kakao user ID: \(user.id)")
//                    print("Kakao user nickname: \(user.kakaoAccount?.profile?.nickname ?? "")")
//                }
//            }
//        }
//    }
}

// TODO: Network Model 정의 이후 구현
//extension LoginViewController {
//    func loginWithAPI(loginRequest: LoginRequest) {
//        AuthAPI.shared.login(loginRequest: loginRequest) { response in
//            switch response {
//            case .success(let loginData):
//                if let data = loginData as? LoginResponse {
//                    UserDefaults.standard.set(loginRequest.socialType, forKey: Const.UserDefaultsKey.socialType)
//                    UserDefaults.standard.set(data.sessionId, forKey: Const.UserDefaultsKey.sessionId)
//                    UserDefaults.standard.set(data.memberId, forKey: Const.UserDefaultsKey.memberId)
//                    UserDefaults.standard.set(Date(), forKey: Const.UserDefaultsKey.updatedAt)
//                    UserDefaults.standard.set(true, forKey: Const.UserDefaultsKey.isLogin)
//                }
//            case .requestError(let resultCode, let message):
//                print("loginWithAPI - requestError: [\(resultCode)] \(message)")
//            case .pathError:
//                print("loginWithAPI - pathError")
//            case .serverError:
//                print("loginWithAPI - serverError")
//            case .networkFail:
//                print("loginWithAPI - networkFail")
//            }
//        }
//    }
//}
