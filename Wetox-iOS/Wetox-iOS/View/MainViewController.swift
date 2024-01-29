//
//  ViewController.swift
//  Wetox-iOS
//
//  Created by Lena on 1/23/24.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    // TODO: constants 값 변경하기
    // TODO: collectionView Compositional 로 변경하기
    private var segmentedControl: UISegmentedControl = {
        let items = ["week", "daily", "badge"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.addTarget(self, action: #selector(tappedSegmentedControl(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 1
        
        segmentedControl.frame = CGRectMake(0, 0, 180, 36)
        segmentedControl.layer.cornerRadius = 5.0
        segmentedControl.backgroundColor = .segmentedBackgroundGrayColor
        segmentedControl.tintColor = .gray
        return segmentedControl
    }()
    
    private let bottomSheetView = BottomSheetView()
    
    private var friendsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        [segmentedControl, friendsCollectionView, bottomSheetView].forEach { view.addSubview($0) }
        configureLayout()
        configureUnselectedSegmentedControl()
        setupCollectionView()
    }
    
    private func configureLayout() {
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(view).offset(16)
            make.width.equalTo(180)
        }
        
        friendsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp_bottomMargin).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.bottom.equalTo(bottomSheetView.snp.top).offset(2)
        }
        
        bottomSheetView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(view)
            $0.height.equalTo(102)
        }
    }
    
    @objc func tappedSegmentedControl(_ segmentedControl: UISegmentedControl) {
        configureUnselectedSegmentedControl()
        switch (segmentedControl.selectedSegmentIndex) {
            case 0:
                segmentedControl.setImage(UIImage(named: "weekly-selected-icon"), forSegmentAt: 0)
            case 1:
                segmentedControl.setImage(UIImage(named: "daily-selected-icon"), forSegmentAt: 1)
            case 2:
                segmentedControl.setImage(UIImage(named: "badge-selected-icon"), forSegmentAt: 2)
            default:
                break
        }
    }
    
    func configureUnselectedSegmentedControl() {
        segmentedControl.setImage(UIImage(named: "weekly-unselected-icon"), forSegmentAt: 0)
        segmentedControl.setImage(UIImage(named: "daily-unselected-icon"), forSegmentAt: 1)
        segmentedControl.setImage(UIImage(named: "badge-unselected-icon"), forSegmentAt: 2)
    }
    
    func setupCollectionView() {
        friendsCollectionView.register(FriendsCollectionViewCell.self, forCellWithReuseIdentifier: FriendsCollectionViewCell.cellIdentifier)
        friendsCollectionView.dataSource = self
        friendsCollectionView.delegate = self
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendsCollectionViewCell.cellIdentifier, for: indexPath) as! FriendsCollectionViewCell
        // 셀의 내용 설정 또는 데이터 로딩
        cell.circularProfileProgressBar.value = 0.64
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 32) / 3
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
