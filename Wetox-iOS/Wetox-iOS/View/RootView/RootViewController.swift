//
//  MainViewController.swift
//  Wetox-iOS
//
//  Created by Lena on 2/16/24.
//

import UIKit

class RootViewController: UIViewController {
    
    lazy var badgeView: BadgeView = {
        let badgeView = BadgeView()
        return badgeView
    }()
    
    lazy var dailyView: DailyView = {
        let dailyView = DailyView()
        return dailyView
    }()
    
    private var segmentedControl: UISegmentedControl = {
        let items = ["week", "daily", "badge"]
        
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.addTarget(self, action: #selector(tappedSegmentedControl(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 1
        
        segmentedControl.frame = CGRectMake(0, 0, 180, 36)
        segmentedControl.layer.cornerRadius = 5.0
        segmentedControl.tintColor = .segmentedBackgroundGrayColor
        return segmentedControl
    }()
    
    private lazy var alarmButton: UIButton = {
        let button = UIButton()
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        let image = UIImage(systemName: "bell.fill", withConfiguration: imageConfig)
        button.tintColor = .unselectedTintColor
        button.setImage(image, for: .normal)
        button.contentMode = .scaleToFill
        button.addTarget(self, action: #selector(alarmButtonTapped), for: .touchUpInside)
        return button
        
    }()
    
    private lazy var settingButton: UIButton = {
        let button = UIButton()
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        let image = UIImage(systemName: "gearshape.fill", withConfiguration: imageConfig)
        button.tintColor = .unselectedTintColor
        button.setImage(image, for: .normal)
        button.contentMode = .scaleToFill
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        setSegmentedControlImages(selectedIndex: segmentedControl.selectedSegmentIndex)
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        [segmentedControl, alarmButton, settingButton, badgeView, dailyView].forEach { view.addSubview($0) }
    }
    
    private func setupLayout() {
        segmentedControl.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview().inset(Constants.Padding.defaultPadding)
            $0.height.equalTo(40)
        }
        
        badgeView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(Constants.Padding.narrowPadding)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(4)
        }
        
        dailyView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(Constants.Padding.narrowPadding)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        settingButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Constants.Padding.defaultPadding)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.width.height.equalTo(42)
        }
        
        alarmButton.snp.makeConstraints {
            $0.trailing.equalTo(settingButton.snp.leading).offset(Constants.Padding.defaultPadding / 10)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.width.height.equalTo(42)
        }
    }
    
    @objc func alarmButtonTapped() {
        let alertViewController = AlertViewController()
        let navigationController = UINavigationController(rootViewController: alertViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }

    @objc func tappedSegmentedControl(_ segmentedControl: UISegmentedControl) {

        setSegmentedControlImages(selectedIndex: segmentedControl.selectedSegmentIndex)
        switch segmentedControl.selectedSegmentIndex {
            case 0:
                dailyView.isHidden = false
                badgeView.isHidden = true
            case 1:
                dailyView.isHidden = false
                badgeView.isHidden = true
            case 2:
                dailyView.isHidden = true
                badgeView.isHidden = false
            default:
                break
        }
    }
    
    private func setSegmentedControlImages(selectedIndex: Int) {

        for index in 0..<segmentedControl.numberOfSegments {
            let iconName = index == selectedIndex ? Constants.Image.selectedSegmentIcons[index] : Constants.Image.segmentIcons[index]
            let image = UIImage(named: iconName)
            segmentedControl.setImage(image, forSegmentAt: index)
        }
    }
}
