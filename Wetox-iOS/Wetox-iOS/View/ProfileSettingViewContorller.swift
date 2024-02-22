//
//  ProfileSettingViewContorller.swift
//  Wetox-iOS
//
//  Created by 김소현 on 1/24/24.
//

import UIKit
import SnapKit
import RxSwift

class ProfileSettingViewContorller: UIViewController {
    let disposeBag = DisposeBag()
    
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
                                               backgroundColor: UIColor.checkRedButtonColor,
                                               radius: 7)
        duplicateCheckButton.addTarget(self, action: #selector(nicknameValidButtonTapped), for: .touchUpInside)
        
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

    @objc func nicknameValidButtonTapped() {
        checkNicknameValidity(nickname: NicknameValidRequest(nickname: nicknameTextField.text ?? String()))
    }

    @objc func AIGenerationButtonTapped() {
         fetchAIProfileImage()
    }
    
    @objc func navigationButtonTapped() {
        let nickname = UserDefaults.standard.string(forKey: Const.UserDefaultsKey.nickname) ?? String()
        let deviceToken = UserDefaults.standard.string(forKey: Const.UserDefaultsKey.deviceToken) ?? String()
        let openId = UserDefaults.standard.string(forKey: Const.UserDefaultsKey.openId) ?? String()

        // TODO: oauthProvider setting 추후 수정하기
        let registerRequest = RegisterRequest(nickname: nickname, oauthProvider: "KAKAO", openId: openId, deviceToken: deviceToken)
        registerWithAPI(registerRequest: registerRequest, profileImage: self.profileImageView.image)
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
    func checkNicknameValidity(nickname: NicknameValidRequest) {
        RegisterAPI.postNicknameValidRequest(nickname: nickname)
            .subscribe(onNext: { response in
                if response.existed {
                    self.showAlert(title: "중복된 닉네임", message: "기존에 사용 중인 닉네임입니다. \n 다른 닉네임을 입력해주세요.")
                } else {
                    UserDefaults.standard.set(nickname.nickname, forKey: Const.UserDefaultsKey.nickname)
                    self.showAlert(title: "사용 가능한 닉네임", message: "사용 가능한 닉네임입니다.")
                    self.AIGenerationButton.backgroundColor = UIColor.allowedButtonColor
                }
            }, onError: { error in
                print("Error occurred during nickname validation: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func fetchAIProfileImage() {
        RegisterAPI.getAIProfileImage()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { imageData in
                guard let image = UIImage(data: imageData) else {
                    print("Failed to convert data to image")
                    return
                }
                self.profileImageView.image = image
            }, onError: { error in
                print("Error: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
    
    func registerWithAPI(registerRequest: RegisterRequest, profileImage: UIImage?) {
        AuthAPI.register(registerRequest: registerRequest, profileImage: profileImage)
            .subscribe(onNext: { registerResponse in
                UserDefaults.standard.set(registerResponse.accessToken, forKey: Const.UserDefaultsKey.accessToken)
                print("accessToken 값 입니다. ")
                print(registerResponse.accessToken)
                self.navigationController?.pushViewController(RootViewController(), animated: true)
                print("회원가입 성공: \(registerResponse)")
            }, onError: { error in
                print("회원가입 실패: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
}
