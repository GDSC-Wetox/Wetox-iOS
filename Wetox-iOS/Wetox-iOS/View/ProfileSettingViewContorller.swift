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

    var titleLabel: UILabel = UILabel()
    
    private func setupLabelLayout() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let doneButton = UILabel()
        doneButton.text = "완료"
        doneButton.textColor = .systemBlue
        
        self.navigationItem.title = "프로필 설정"
        self.navigationItem.setRightBarButton(UIBarButtonItem(customView: doneButton), animated: false)
        
        doneButton.isUserInteractionEnabled = true
        
//        // 제스처인식기 생성
//        let doneLblTappedRecognizer = UITapGestureRecognizer(target: self, action: #selector(doneLblTapped(tapGestureRecognizer:)))
//        // 상호작용 설정
//        doneLlb.isUserInteractionEnabled = true
//        // 제스처인식기 연결
//        doneLlb.addGestureRecognizer(doneLblTappedRecognizer)
        
        setupLabelLayout()
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
