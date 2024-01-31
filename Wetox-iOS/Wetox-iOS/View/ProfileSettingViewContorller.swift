//
//  ProfileSettingViewContorller.swift
//  Wetox-iOS
//
//  Created by 김소현 on 1/24/24.
//

import UIKit
import SnapKit

class ProfileSettingViewContorller: UIViewController {
    
    var accessToken = ""
    var nickname = ""
    var image: UIImage?

    private let nicknameLabel: UILabel = UILabel()
    let nicknameTextField = UITextField()
    var duplicateCheckButton: UIButton = UIButton()
    private let guidingLabel: UILabel = UILabel()


    private let profileLabel: UILabel = UILabel()
    var profileImageView: UIImageView = UIImageView(image: UIImage(named: "default-profile-icon"))
    var AIGenerationButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "프로필 설정"
        
        [nicknameLabel, nicknameTextField, duplicateCheckButton, guidingLabel, profileLabel, profileImageView, AIGenerationButton].forEach { view.addSubview($0) }
        
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
        nicknameTextField.setUnderLine(lineColor: UIColor.textFieldLineColor)
        nicknameTextField.placeholder = "닉네임을 입력해주세요"
    }
    
    private func setupButtonLayout () {
        duplicateCheckButton.setRooundedButton(title: "중복검사",
                                               titleSize: 12,
                                               titleColor: .white,
                                               backgroundColor: UIColor.blockedButtonColor,
                                               radius: 7)
        
        AIGenerationButton.setRooundedButton(title: "AI 사진 생성",
                                             titleSize: 14,
                                             titleColor: .white,
                                             backgroundColor: UIColor.blockedButtonColor,
                                             radius: 15)
    }
    
    private func configureLayout() {
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(141)
            make.leading.equalToSuperview().inset(20)
        }
        
        guidingLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(216)
            make.leading.trailing.equalToSuperview().inset(18)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(170)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(276)
            make.height.equalTo(41)
        }
        
        duplicateCheckButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(175)
            make.leading.equalToSuperview().inset(295)
            make.width.equalTo(65)
            make.height.equalTo(37)
        }
        
        profileLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(295)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(342)
            make.centerX.equalTo(self.view)
            make.width.equalTo(242)
            make.height.equalTo(242)
        }
        
        AIGenerationButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(627)
            make.leading.trailing.equalToSuperview().inset(33)
            make.width.equalTo(309)
            make.height.equalTo(45)
        }
    }
}

extension ProfileSettingViewContorller {
    func socialSignUpWithAPI(socialSignUpRequest: SocialSignUpRequest, profileImage: UIImage?) {
        AuthAPI.shared.socialSignUp(socialSignUpRequest: socialSignUpRequest, profileImage: profileImage) { response in
            switch response {
            case .success(let socialSignUpData):
                if let data = socialSignUpData as? SocialSignUpResponse {
                    UserDefaults.standard.set(socialSignUpRequest.socialType, forKey: Const.UserDefaultsKey.socialType)
                    UserDefaults.standard.set(data.accessToken, forKey: Const.UserDefaultsKey.accessToken)
                    UserDefaults.standard.set(Date(), forKey: Const.UserDefaultsKey.updatedAt)
                    UserDefaults.standard.set(true, forKey: Const.UserDefaultsKey.isLogin)
                    self.navigationController?.pushViewController(MainViewController(), animated: true)
                }
                print("socialSignUpWithAPI - success")
            case .requestError(let resultCode, let message):
                print("socialSignUpWithAPI - requestError: [\(resultCode)] \(message)")
            case .pathError:
                print("socialSignUpWithAPI - pathError")
            case .serverError:
                print("socialSignUpWithAPI - serverError")
            case .networkFail:
                print("socialSignUpWithAPI - networkFail")
            }
        }
    }
}
