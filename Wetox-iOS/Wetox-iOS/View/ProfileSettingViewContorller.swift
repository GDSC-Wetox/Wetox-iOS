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
    var profileImageView: UIImageView = UIImageView(image: .checkmark)
    var AIGenerationButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "프로필 설정"
        
        [nicknameLabel, nicknameTextField, duplicateCheckButton, guidingLabel, profileLabel, profileImageView, AIGenerationButton].forEach { view.addSubview($0) }
        
        setupLabelLayout()
        configureLayout()
    }
    
    
    private func setupLabelLayout() {
        nicknameLabel.setLabel(labelText: "닉네임",
                               backgroundColor: .clear,
                               weight: .bold,
                               textSize: 17,
                               labelColor: .black)
    }
    
    private func configureLayout() {
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(141)
            make.leading.trailing.equalToSuperview().inset(20)
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
