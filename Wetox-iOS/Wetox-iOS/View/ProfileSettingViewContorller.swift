//
//  ProfileSettingViewContorller.swift
//  Wetox-iOS
//
//  Created by 김소현 on 1/24/24.
//

import UIKit
import SnapKit

class ProfileSettingViewContorller: UIViewController {
    // TODO: RX로 버튼 반응 코드 작성하기, 토큰 메인 뷰로 넘기기 
    
    var openId = ""
    var nickname = ""
    var generatedAIImage: UIImage?

    private var navigationButton: UIButton = UIButton()

    private let nicknameLabel: UILabel = UILabel()
    private let nicknameTextField = UITextField()
    private var nameDeleteButton: UIButton = UIButton()

    private var duplicateCheckButton: UIButton = UIButton()
    private let guidingLabel: UILabel = UILabel()

    private let profileLabel: UILabel = UILabel()
    private var profileImageView: UIImageView = UIImageView(image: UIImage(named: "default-profile-icon"))
    private var AIGenerationButton: UIButton = UIButton()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nicknameTextField.setUnderLine(lineColor: UIColor.blockedButtonColor)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "프로필 설정"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: navigationButton)
        
        [navigationButton, nicknameLabel, nicknameTextField, nameDeleteButton, duplicateCheckButton, guidingLabel, profileLabel, profileImageView, AIGenerationButton].forEach { view.addSubview($0) }
        
        setupLabelLayout()
        setupTextFieldLayout()
        setupButtonLayout()
        configureLayout()
        
        nicknameTextField.becomeFirstResponder()
    }
    
    private func setupLabelLayout() {
        nicknameLabel.setLabel(labelText: "닉네임",
                               backgroundColor: .clear,
                               weight: .bold,
                               textSize: 17,
                               labelColor: .black)
        
        guidingLabel.setLabel(labelText: "⋅ 닉네임을 통해 친구를 검색하고 친구 신청을 할 수 있습니다.",
                              backgroundColor: .clear,
                              weight: .medium,
                              textSize: 12,
                              labelColor: UIColor.guidingGrayColor)
        
        profileLabel.setLabel(labelText: "프로필 설정",
                              backgroundColor: .clear,
                              weight: .bold,
                              textSize: 17,
                              labelColor: .black)
    }
    
    private func setupTextFieldLayout() {
        nicknameTextField.placeholder = "닉네임을 입력해주세요"
        nicknameTextField.backgroundColor = .clear
    }
    
    private func setupButtonLayout () {
        navigationButton.setTitle("완료", for: .normal)
        navigationButton.setTitleColor(.systemBlue, for: .normal)
        navigationButton.addTarget(self, action: #selector(navigationButtonTapped), for: .touchUpInside)
        
        nameDeleteButton.setBackgroundImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        nameDeleteButton.tintColor = UIColor.textDeleteButtonColor
        nameDeleteButton.addTarget(self, action: #selector(nameDeleteButtonTapped), for: .touchUpInside)

        duplicateCheckButton.setRooundedButton(title: "중복검사",
                                               titleSize: 12,
                                               titleColor: .white,
                                               backgroundColor: UIColor.blockedButtonColor,
                                               radius: 7)
        duplicateCheckButton.addTarget(self, action: #selector(duplicateCheckButtonTapped), for: .touchUpInside)
        
        AIGenerationButton.setRooundedButton(title: "AI 사진 생성",
                                             titleSize: 14,
                                             titleColor: .white,
                                             backgroundColor: UIColor.blockedButtonColor,
                                             radius: 15)
        AIGenerationButton.addTarget(self, action: #selector(AIGenerationButtonTapped), for: .touchUpInside)
    }
    
    @objc func nameDeleteButtonTapped() {
        nicknameTextField.text = ""
    }

    @objc func duplicateCheckButtonTapped() {
        // TODO: API 연결 구현
        // TODO: Alert view 구현
    }

    @objc func AIGenerationButtonTapped() {
        // TODO: AI 생성 API 연결
    }
    
    @objc func navigationButtonTapped() {
        let nickname = nicknameTextField.text!
        // TODO: deviceToken 연동
        let registerRequest = RegisterRequest(nickname: nickname, oauthProvider: "KAKAO", openId: self.openId, deviceToken: "deviceToken")
        registerWithAPI(registerRequest: registerRequest, profileImage: UIImage(named: "default-profile-icon"))
    }
    
    private func configureLayout() {
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(81)
            make.leading.equalToSuperview().inset(20)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(110)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(256)
            make.height.equalTo(41)
        }
        
        nameDeleteButton.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField).offset(13)
            make.leading.equalTo(nicknameTextField).inset(225)
            make.width.equalTo(17)
            make.height.equalTo(17)
        }
        
        guidingLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(166)
            make.leading.trailing.equalToSuperview().inset(18)
        }
        
        duplicateCheckButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(115)
            make.leading.equalToSuperview().inset(295)
            make.width.equalTo(65)
            make.height.equalTo(37)
        }
        
        profileLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(235)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(282)
            make.centerX.equalTo(self.view)
            make.width.equalTo(242)
            make.height.equalTo(242)
        }
        
        AIGenerationButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(567)
            make.leading.trailing.equalToSuperview().inset(33)
            make.width.equalTo(309)
            make.height.equalTo(45)
        }
    }
}

extension ProfileSettingViewContorller {
    func registerWithAPI(registerRequest: RegisterRequest, profileImage: UIImage?) {
        AuthAPI.shared.register(registerRequest: registerRequest, profileImage: profileImage) { response in
            switch response {
            case .success(let registerData):
                if let data = registerData as? RegisterResponse {
                    UserDefaults.standard.set(data.accessToken, forKey: Const.UserDefaultsKey.accessToken)
                    print("accessToken 값 입니다. ")
                    print(data.accessToken) // 확인
                    self.navigationController?.pushViewController(MainViewController(), animated: true)
                }
                print("registerWithAPI - success")
            case .requestError:
                print("registerWithAPI - requestError")
            case .pathError:
                print("registerWithAPI - pathError")
            case .serverError:
                print("registerWithAPI - serverError")
            case .networkFail:
                print("registerWithAPI - networkFail")
            }
        }
    }
}
