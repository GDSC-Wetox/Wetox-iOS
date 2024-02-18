//
//  FriendshipViewController.swift
//  Wetox-iOS
//
//  Created by 김소현 on 2/15/24.
//

import UIKit
import SnapKit
import RxSwift

class FriendshipViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    private var navigationButton: UIButton = UIButton()
    private let nicknameLabel: UILabel = UILabel()
    private let searchTextField = UITextField()
    private var textDeleteButton: UIButton = UIButton()
    private var friendSearchButton: UIButton = UIButton()
    private let checkingLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.navigationItem.title = "친구 추가"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: navigationButton)

        [navigationButton, nicknameLabel, searchTextField, textDeleteButton, friendSearchButton, checkingLabel].forEach { view.addSubview($0) }
        
        setupLabelLayout()
        setupTextFieldLayout()
        setupButtonLayout()
        configureLayout()
        
        searchTextField.becomeFirstResponder()
//        searchTextField.rx.text
//                   .map { $0 ?? "" } 
//                   .map { $0.isEmpty }
//                   .subscribe(onNext: { [weak self] isEmpty in
//                       self?.checkingLabel.textColor = isEmpty ? .clear : UIColor.allowedButtonColor
//                   })
//                   .disposed(by: disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchTextField.setUnderLine(lineColor: UIColor.blockedButtonColor)
    }
    
    private func setupLabelLayout() {
        nicknameLabel.setLabel(labelText: "닉네임",
                               backgroundColor: .clear,
                               weight: .bold,
                               textSize: 17,
                               labelColor: .black)
        
        checkingLabel.setLabel(labelText: "존재하는 사용자입니다.",
                               backgroundColor: .clear,
                               weight: .light,
                               textSize: 12,
                               labelColor: UIColor.allowedButtonColor)
    }
    
    private func setupTextFieldLayout() {
        searchTextField.placeholder = "친구의 닉네임을 입력해주세요"
        searchTextField.backgroundColor = .clear
    }
    
    private func setupButtonLayout() {
        navigationButton.setTitle("완료", for: .normal)
        navigationButton.setTitleColor(.systemBlue, for: .normal)
        navigationButton.addTarget(self, action: #selector(navigationButtonTapped), for: .touchUpInside)
        
        textDeleteButton.setBackgroundImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        textDeleteButton.tintColor = UIColor.textDeleteButtonColor
        textDeleteButton.addTarget(self, action: #selector(textDeleteButtonTapped), for: .touchUpInside)
        
        friendSearchButton.setRooundedButton(title: "찾기",
                                               titleSize: 12,
                                               titleColor: .white,
                                             backgroundColor: UIColor.checkRedButtonColor,
                                               radius: 7)
        friendSearchButton.addTarget(self, action: #selector(friendSearchButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func navigationButtonTapped() {
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func textDeleteButtonTapped() {
        searchTextField.text = String()
    }
    
    @objc func friendSearchButtonTapped() {
        // TODO: API 호출 need
        
        let alertController = UIAlertController(title: "친구 추가 성공", message: "친구 신청이 완료되었습니다.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    private func configureLayout() {
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(81)
            make.leading.equalToSuperview().inset(20)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(110)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(280)
            make.height.equalTo(41)
        }
        
        textDeleteButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(125)
            make.leading.equalToSuperview().inset(282)
        }
        
        friendSearchButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(118)
            make.leading.equalToSuperview().inset(320)
            make.width.equalTo(57)
            make.height.equalTo(37)
        }
        
        checkingLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(169)
            make.leading.equalToSuperview().inset(19)
        }
    }
}

extension FriendshipViewController {
    func searchFriendAPI(nicknameText: String) {
        // UserAPI에 추가되어야 하는 함수
        
    }
    
    /*
    func registerWithAPI(registerRequest: RegisterRequest, profileImage: UIImage?) {
        AuthAPI.register(registerRequest: registerRequest, profileImage: profileImage)
            .subscribe(onNext: { registerResponse in
                UserDefaults.standard.set(registerResponse.accessToken, forKey: Const.UserDefaultsKey.accessToken)
                print("accessToken 값 입니다. ")
                print(registerResponse.accessToken) // 확인
                self.navigationController?.pushViewController(MainViewController(), animated: true)
                print("회원가입 성공: \(registerResponse)")
            }, onError: { error in
                print("회원가입 실패: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
     */
}