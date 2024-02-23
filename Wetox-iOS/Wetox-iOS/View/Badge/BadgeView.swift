//
//  BadgeViewController.swift
//  Wetox-iOS
//
//  Created by Lena on 2/15/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class BadgeView: UIView {
    
    private var badgeViewModel = BadgeViewModel()
    private var disposeBag = DisposeBag()
    private var rewardedBadgeNames: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureCollectionView()
        badgeViewModel.fetchBadges()
        bindBadge()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var badgeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 6
        layout.minimumLineSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BadgeCollectionViewCell.self, forCellWithReuseIdentifier: BadgeCollectionViewCell.cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.allowsMultipleSelection = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private func configureCollectionView() {
        addSubview(badgeCollectionView)
        
        badgeCollectionView.snp.makeConstraints {
            $0.leading.top.trailing.bottom.equalToSuperview().inset(4)
        }
        
    }
}

extension BadgeView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BadgeCollectionViewCell.cellIdentifier, for: indexPath) as? BadgeCollectionViewCell else {
            fatalError("dequeue BadgeCollectionViewCell 불가 에러 ")
        }

        let activityType: ActivityType = [.game, .book, .sns, .youtube][indexPath.row / 3 % 4]
        let timePeriod: TimePeriod = [.day, .week, .month][indexPath.row % 3]
        let activityState: ActivityState = timePeriod == .month ? .inactive(activityType, timePeriod) : .active(activityType, timePeriod)
        
        let imageName = activityState.imageName
        cell.badgeImageView.image = UIImage(named: imageName)
        cell.badgeLabel.text = imageName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPaddingSpace: CGFloat = 20
        let heightPaddingSpace: CGFloat = 36
        let availableWidth = collectionView.frame.width - widthPaddingSpace
        let availableHeight = collectionView.frame.height - heightPaddingSpace
        return CGSize(width: availableWidth / 3, height: availableHeight / 4)
    }
}

extension BadgeView {
    func bindBadge() {
        badgeViewModel.rewardedBadgeNames
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] badgeNames in
                self?.rewardedBadgeNames = badgeNames
                print("rewardedBadgeNames: \(self?.rewardedBadgeNames)")
                // TODO: UI 업데이트 구현 
            })
            .disposed(by: disposeBag)
    }
}
