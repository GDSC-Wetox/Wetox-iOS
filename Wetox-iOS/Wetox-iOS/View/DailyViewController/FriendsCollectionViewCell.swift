//
//  File.swift
//  Wetox-iOS
//
//  Created by Lena on 1/23/24.
//

import UIKit

class FriendsCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "FriendsCollectionViewCell"
    
    var circularProfileProgressBar: CircularProgressBar = {
        let progressBar = CircularProgressBar()
        progressBar.backgroundColor = .systemBackground
        return progressBar
    }()
    
    var nicknameLabel: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        circularProfileProgressBar.setProgress(self.bounds)
        setupLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        circularProfileProgressBar.setProgress(bounds)
    }

    
    /// 재사용 시 value 값을 초기화
    override func prepareForReuse() {
        super.prepareForReuse()
        circularProfileProgressBar.profileImageView.image = nil
        circularProfileProgressBar.value = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        self.backgroundColor = .systemBackground
        
        nicknameLabel.setLabel(labelText: "",
                               backgroundColor: .clear,
                               weight: .medium,
                               textSize: 14,
                               labelColor: UIColor.unselectedTintColor)
        
        [circularProfileProgressBar, nicknameLabel].forEach { self.addSubview($0)}
//        circularProfileProgressBar.profileImageView.image = UIImage(systemName: "person.fill")
        circularProfileProgressBar.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        nicknameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(circularProfileProgressBar.snp.bottom)
        }
    }
    
}
