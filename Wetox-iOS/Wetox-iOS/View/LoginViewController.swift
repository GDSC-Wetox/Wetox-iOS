//
//  LoginViewController.swift
//  Wetox-iOS
//
//  Created by 김소현 on 1/24/24.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    var subTitleLabel: UILabel = UILabel()
    var titleLabel: UILabel = UILabel()

    private func setupLayout() {
        
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
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        [subTitleLabel, titleLabel].forEach { view.addSubview($0) }

        setupLayout()
        configureLayout()
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
    }
}
