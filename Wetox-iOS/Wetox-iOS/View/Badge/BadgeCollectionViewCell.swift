//
//  BadgeCollectionViewCell.swift
//  Wetox-iOS
//
//  Created by Lena on 2/15/24.
//

import UIKit

class BadgeCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "BadgeCollectionViewCell"
    
    lazy var badgeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var badgeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
//        setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        badgeImageView.image = nil
        badgeLabel.text = String()
    }
    
    private func setupViews() {
        contentView.addSubview(badgeImageView)
        contentView.addSubview(badgeLabel)
        contentView.backgroundColor = .clear
        badgeLabel.setLabel(labelText: String(), backgroundColor: .clear, weight: .light, textSize: 10, labelColor: .lightGray)
        badgeLabel.textAlignment = .center
        
        badgeImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(10)
            $0.bottom.equalTo(badgeLabel.snp.top)
        }
        
        badgeLabel.snp.makeConstraints {
            $0.top.equalTo(badgeImageView.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(10)
            $0.leading.trailing.equalToSuperview().inset(4)
        }
    }
}
