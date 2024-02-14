//
//  ViewController.swift
//  Wetox-iOS
//
//  Created by Lena on 1/23/24.
//

import UIKit
import SnapKit
import RxSwift

class MainViewController: UIViewController {
    
    var mainViewModel: MainViewModel!
    var disposeBag = DisposeBag()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        mainViewModel = MainViewModel()
        [segmentedControl, friendsCollectionView, bottomSheetView].forEach { view.addSubview($0) }
        bottomSheetView.addSubview(dragIndicatorView)
        configureLayout()
        configureUnselectedSegmentedControl()
        setupCollectionView()
        recognizeGesture()
        navigationController?.isNavigationBarHidden = true
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
            $0.height.equalTo(96)
        }
        
        dragIndicatorView.snp.makeConstraints {
            $0.top.equalTo(bottomSheetView.snp.top).inset(10)
            $0.centerX.equalTo(bottomSheetView.snp.centerX)
            $0.width.equalTo(30)
            $0.height.equalTo(3)
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
    
    private func recognizeGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttomSheetViewTapped(_:)))
        self.bottomSheetView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func buttomSheetViewTapped(_ sender: UITapGestureRecognizer) {
        let screenTimeInputViewController = ScreenTimeInputViewController()
        let navigationController = UINavigationController(rootViewController: screenTimeInputViewController)
        navigationController.modalPresentationStyle = .formSheet
        navigationController.sheetPresentationController?.prefersGrabberVisible = true
        navigationController.modalTransitionStyle = .coverVertical
        self.present(navigationController, animated: true)
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendsCollectionViewCell.cellIdentifier, for: indexPath) as! FriendsCollectionViewCell
        // 셀의 내용 설정 또는 데이터 로딩
        cell.nicknameLabel.text = ""
        cell.circularProfileProgressBar.profileImageView.image = UIImage(systemName: "person")
        cell.circularProfileProgressBar.value = 0.64
        
        if indexPath.row == 0 {
            
            mainViewModel.myProfile
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { [weak self] myProfile in
                    cell.nicknameLabel.text = myProfile.nickname
                    cell.circularProfileProgressBar.profileImageView.image = UIImage(named: myProfile.imageName)
                })
                .disposed(by: disposeBag)
            
            mainViewModel.percentage
                 .observe(on: MainScheduler.instance)
                 .subscribe(onNext: { [weak self] percentage in
                     cell.circularProfileProgressBar.value = percentage
                 })
                 .disposed(by: disposeBag)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 32) / 3
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
