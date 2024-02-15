//
//  FriendshipViewController.swift
//  Wetox-iOS
//
//  Created by 김소현 on 2/15/24.
//

import UIKit
import SnapKit

class FriendshipViewController: UIViewController {
    
    private var navigationButton: UIButton = UIButton()

    private let nicknameLabel: UILabel = UILabel()
    private let searchTextField = UITextField()
    private var textDeleteButton: UIButton = UIButton()
    private let checkingLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "친구 추가"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: navigationButton)
        
        [navigationButton, nicknameLabel, searchTextField, textDeleteButton, checkingLabel].forEach { view.addSubview($0) }
        
        setupLabelLayout()
        setupTextFieldLayout()
        setupButtonLayout()
        configureLayout()
        
        searchTextField.becomeFirstResponder()
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
        
    }
    
    private func setupButtonLayout() {
        
    }
    
    private func configureLayout() {
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(81)
            make.leading.equalToSuperview().inset(20)
        }
    }
}
