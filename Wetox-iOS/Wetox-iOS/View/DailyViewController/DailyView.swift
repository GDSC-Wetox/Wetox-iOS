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
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        commonInit()
        setupChartView()
        setupTapGestureRecognizer()
    }
    
    private func commonInit() {
        backgroundColor = .systemBackground
//        mainViewModel = MainViewModel()
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendsCollectionViewCell.cellIdentifier, for: indexPath) as! FriendsCollectionViewCell
        
        // 마지막 셀인 경우
        if indexPath.item == collectionView.numberOfItems(inSection: indexPath.section) - 1 {
            cell.circularProfileProgressBar.profileImageView.contentMode = .center
            cell.circularProfileProgressBar.profileImageView.image = UIImage(named: "plus")
            cell.circularProfileProgressBar.value = 0.0
            cell.circularProfileProgressBar.lineWidth = CGFloat(0.0)
            cell.nicknameLabel.text = "new"
            friendsCollectionView.reloadInputViews()
        } 
        
        if indexPath.row == 0 {
            
            /* TODO: 추후 제대로 구현
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
            
            // TODO: 이미지 비율 문제 수정하기
            cell.circularProfileProgressBar.profileImageView.image = UIImage(named: "AppIcon")
            cell.circularProfileProgressBar.value = 0.35 // yellow
            cell.circularProfileProgressBar.lineColor = .wetoxYellow
            cell.nicknameLabel.text = "Colli"
            cell.circularProfileProgressBar.profileImageView.contentMode = .scaleAspectFill
            cell.circularProfileProgressBar.profileImageView.clipsToBounds = true

            let cellWidth = (collectionView.frame.width - 32) / 3
            cell.circularProfileProgressBar.profileImageView.frame = CGRect(x: 0, y: 0, width: cellWidth, height: cellWidth)

            friendsCollectionView.reloadInputViews()
            
        }
        
        if indexPath.row == 1 {

            cell.circularProfileProgressBar.profileImageView.image = UIImage(named: "image2")
            cell.circularProfileProgressBar.value = 0.12 // green
            cell.circularProfileProgressBar.lineColor = .wetoxGreen
            cell.nicknameLabel.text = "Lena"
            cell.circularProfileProgressBar.profileImageView.contentMode = .scaleAspectFill
            cell.circularProfileProgressBar.profileImageView.clipsToBounds = true

            let cellWidth = (collectionView.frame.width - 32) / 3
            cell.circularProfileProgressBar.profileImageView.frame = CGRect(x: 0, y: 0, width: cellWidth, height: cellWidth)

            friendsCollectionView.reloadInputViews()
            
        }
        
        if indexPath.row == 2 {
            cell.circularProfileProgressBar.profileImageView.image = UIImage(named: "image3")
            cell.circularProfileProgressBar.value = 0.63 // orange
            cell.circularProfileProgressBar.lineColor = .wetoxOrange
            cell.nicknameLabel.text = "hyein"
            cell.circularProfileProgressBar.profileImageView.contentMode = .scaleAspectFill
            cell.circularProfileProgressBar.profileImageView.clipsToBounds = true

            let cellWidth = (collectionView.frame.width - 32) / 3
            cell.circularProfileProgressBar.profileImageView.frame = CGRect(x: 0, y: 0, width: cellWidth, height: cellWidth)

            friendsCollectionView.reloadInputViews()
            
        }
        
        if indexPath.row == 3 {
            cell.circularProfileProgressBar.profileImageView.image = UIImage(named: "image4")
            cell.circularProfileProgressBar.value = 0.85 // red
            cell.circularProfileProgressBar.lineColor = .wetoxRed
            cell.nicknameLabel.text = "jison"
            cell.circularProfileProgressBar.profileImageView.contentMode = .scaleAspectFill
            cell.circularProfileProgressBar.profileImageView.clipsToBounds = true

            let cellWidth = (collectionView.frame.width - 32) / 3
            cell.circularProfileProgressBar.profileImageView.frame = CGRect(x: 0, y: 0, width: cellWidth, height: cellWidth)

            friendsCollectionView.reloadInputViews()
            
        }
        
        // TODO: 친구들 프로필 띄우기
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 32) / 3
        return CGSize(width: cellWidth, height: cellWidth)
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item == collectionView.numberOfItems(inSection: indexPath.section) - 1 {
            chartView.isHidden = true
            let friendshipViewController = FriendshipViewController()
            let navigationController = UINavigationController(rootViewController: friendshipViewController)
            navigationController.modalPresentationStyle = .fullScreen
            if let viewController = self.findViewController() {
                viewController.present(navigationController, animated: true)
            }
        } else {
            setupTapGestureRecognizer()
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
        
        // 터치가 발생한 뷰가 UICollectionViewCell이거나 그 하위 뷰인지 확인
        if touch.view is UICollectionViewCell || touch.view?.superview is UICollectionViewCell {
            // 터치가 UICollectionViewCell에서 발생한 경우 제스처 인식을 무시
            return false
        } else {
            return touch.view != chartView
        }
    }
}
