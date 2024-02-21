//
//  AlertTableViewCell.swift
//  Wetox-iOS
//
//  Created by 김소현 on 2/18/24.
//

import UIKit

@objc protocol AlertTableViewCellDelegate {
    func presentAcceptAlertController(toId: Int64)
    func presentRejectAlertController(toId: Int64)
}

class AlertTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "AlertTableCell"
    
    let friendRequestLabel = UILabel()
    let acceptButton = UIButton()
    let rejectButton = UIButton()
    
    weak var delegate: AlertTableViewCellDelegate?
    var indexPath: IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none;

        setupButtonLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtonLayout() {
        rejectButton.setRooundedButton(title: "거절",
                                       titleSize: 12,
                                       titleColor: .black,
                                       backgroundColor: UIColor.greyRejectButton,
                                       radius: 7)
        
        acceptButton.setRooundedButton(title: "수락",
                                       titleSize: 12,
                                       titleColor: .white,
                                       backgroundColor: UIColor.allowedButtonColor,
                                       radius: 7)
        
        rejectButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        acceptButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)

        acceptButton.addTarget(self, action: #selector(acceptButtonTapped), for: .touchUpInside)
        rejectButton.addTarget(self, action: #selector(rejectButtonTapped), for: .touchUpInside)
    }
    
    @objc func acceptButtonTapped() {
        let alertController = UIAlertController(title: "친구 추가 완료", message: "친구 요청을 수락하였습니다.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
//        delegate?.presentAcceptAlertController()
    }
    
    @objc func rejectButtonTapped() {
        let alertController = UIAlertController(title: "친구 요청 거절", message: "친구 요청을 거절하였습니다.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
//        delegate?.presentRejectAlertController()
    }
    
    private func configureUI() {
        [friendRequestLabel, acceptButton, rejectButton].forEach { contentView.addSubview($0) }
        
        friendRequestLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(23)
        }
        
        rejectButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(11.5)
            make.leading.equalToSuperview().offset(258)
            make.width.equalTo(51)
            make.height.equalTo(27)
        }
        
        acceptButton.snp.makeConstraints { make in
            make.top.equalTo(rejectButton)
            make.leading.equalTo(rejectButton).offset(61)
            make.width.equalTo(rejectButton)
            make.height.equalTo(rejectButton)
        }
    }
}
