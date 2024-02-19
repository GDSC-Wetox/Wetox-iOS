//
//  AlertTableViewCell.swift
//  Wetox-iOS
//
//  Created by 김소현 on 2/18/24.
//

import UIKit

protocol AlertTableViewCellDelegate: AnyObject {
    func acceptButtonTapped(at indexPath: IndexPath)
    func rejectButtonTapped(at indexPath: IndexPath)
}

class AlertTableViewCell: UITableViewCell {
    static let reuseIdentifier = "AlertTableCell"
    
    let nameLabel = UILabel()
    let acceptButton = UIButton(type: .system)
    let rejectButton = UIButton(type: .system)
    
    weak var delegate: AlertTableViewCellDelegate?
    var indexPath: IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(acceptButton)
        contentView.addSubview(rejectButton)
        
        acceptButton.setTitle("수락", for: .normal)
        acceptButton.addTarget(self, action: #selector(acceptButtonTapped), for: .touchUpInside)
        
        rejectButton.setTitle("거절", for: .normal)
        rejectButton.addTarget(self, action: #selector(rejectButtonTapped), for: .touchUpInside)
    }
    
    @objc private func acceptButtonTapped() {
        guard let indexPath = indexPath else { return }
        delegate?.acceptButtonTapped(at: indexPath)
    }
    
    @objc private func rejectButtonTapped() {
        guard let indexPath = indexPath else { return }
        delegate?.rejectButtonTapped(at: indexPath)
    }
}
