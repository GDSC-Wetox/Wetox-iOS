//
//  DailyView.swift
//  Wetox-iOS
//
//  Created by Lena on 2/16/24.
//

import UIKit
import SnapKit
import RxSwift

class DailyView: UIView {
    
    var mainViewModel: MainViewModel!
    var disposeBag = DisposeBag()
    
    private let chartView = ChartView()
    private let bottomSheetView: BottomSheetView = {
        let view = BottomSheetView()
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let dragIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .unselectedTintColor
        view.layer.cornerRadius = 1.5
        view.clipsToBounds = true
        view.alpha = 0.5
        return view
    }()
    
    private var friendsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setupChartView()
        setupTapGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        commonInit()
        setupChartView()
        setupTapGestureRecognizer()
    }
    
    private func commonInit() {
        backgroundColor = .systemBackground
        mainViewModel = MainViewModel()
        [friendsCollectionView, bottomSheetView, chartView].forEach { addSubview($0) }
        bottomSheetView.addSubview(dragIndicatorView)
        setupLayout()
        setupCollectionView()
        recognizeGesture()
    }
    
    private func setupLayout() {
        friendsCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(Constants.Padding.defaultPadding)
            make.bottom.equalTo(bottomSheetView.snp.top).offset(-2)
        }
        
        bottomSheetView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(96)
        }
        
        dragIndicatorView.snp.makeConstraints { make in
            make.top.equalTo(bottomSheetView.snp.top).inset(10)
            make.centerX.equalTo(bottomSheetView.snp.centerX)
            make.width.equalTo(30)
            make.height.equalTo(3)
        }
        
        chartView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(340)
        }
    }
    
    private func setupCollectionView() {
        friendsCollectionView.register(FriendsCollectionViewCell.self, forCellWithReuseIdentifier: FriendsCollectionViewCell.cellIdentifier)
        friendsCollectionView.dataSource = self
        friendsCollectionView.delegate = self
    }
    
    private func recognizeGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(bottomSheetViewTapped(_:)))
        bottomSheetView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func bottomSheetViewTapped(_ sender: UITapGestureRecognizer) {
        let screenTimeInputViewController = ScreenTimeInputViewController()
        let navigationController = UINavigationController(rootViewController: screenTimeInputViewController)
        navigationController.modalPresentationStyle = .formSheet
        navigationController.sheetPresentationController?.prefersGrabberVisible = true
        navigationController.modalTransitionStyle = .coverVertical
        
        if let viewController = self.findViewController() {
            viewController.present(navigationController, animated: true)
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension DailyView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: 서버에서 받아오는 친구 수 + 1 하기
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendsCollectionViewCell.cellIdentifier, for: indexPath) as! FriendsCollectionViewCell
        
        // 마지막 셀인 경우
        if indexPath.item == collectionView.numberOfItems(inSection: indexPath.section) - 1 {
            cell.circularProfileProgressBar.profileImageView.image = UIImage(named: "plus")
            cell.circularProfileProgressBar.value = 0.0
            cell.circularProfileProgressBar.lineWidth = CGFloat(0.0)
            cell.nicknameLabel.text = "new"
            friendsCollectionView.reloadInputViews()
            
        }
        
        if indexPath.item == 0 {
            
            /*
            // 자신의 Profile
            mainViewModel.myProfile
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { myProfile in
                    cell.nicknameLabel.text = myProfile.nickname
                    cell.circularProfileProgressBar.profileImageView.image = UIImage(named: "AppIcon")
                })
                .disposed(by: disposeBag)
            
            mainViewModel.percentage
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { percentage in
                    cell.circularProfileProgressBar.value = percentage
                })
                .disposed(by: disposeBag)
             */
            cell.nicknameLabel.text = "lena"
            cell.circularProfileProgressBar.profileImageView.image = UIImage(named: "AppIcon")
            friendsCollectionView.reloadInputViews()
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 32) / 3
        return CGSize(width: cellWidth, height: cellWidth)
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item == collectionView.numberOfItems(inSection: indexPath.section) - 1 {
            let friendshipViewController = FriendshipViewController()
            let navigationController = UINavigationController(rootViewController: friendshipViewController)
            navigationController.modalPresentationStyle = .fullScreen
            if let viewController = self.findViewController() {
                viewController.present(navigationController, animated: true)
            }
        } else {
            chartView.isHidden = false
        }
    }
    
}

extension DailyView: UIGestureRecognizerDelegate {
    private func setupChartView() {
        addSubview(chartView)
        chartView.isHidden = true
        
        chartView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(340)
        }
    }
    
    private func setupTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGestureRecognizer.delegate = self
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        // ChartView의 isHidden 속성을 반전시켜 숨김/표시 상태 전환
        chartView.isHidden = !chartView.isHidden
    }
    
    // UIGestureRecognizerDelegate 메서드
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view != chartView
    }
}
