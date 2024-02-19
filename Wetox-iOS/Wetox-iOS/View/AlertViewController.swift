//
//  AlertViewController.swift
//  Wetox-iOS
//
//  Created by 김소현 on 2/15/24.
//

import UIKit
import SnapKit
import RxSwift

class AlertViewController: UIViewController {
    let disposeBag = DisposeBag()
    let tableView = UITableView()
    
    private var navigationButton: UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AlertTableViewCell.self, forCellReuseIdentifier: AlertTableViewCell.reuseIdentifier)

        
        self.navigationItem.title = "알림"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: navigationButton)
        
        [navigationButton, tableView].forEach { view.addSubview($0) }
        
        configureLayout()
    }
    
    private func configureLayout() {
        navigationButton.setTitle("닫기", for: .normal)
        navigationButton.setTitleColor(.systemBlue, for: .normal)
        navigationButton.addTarget(self, action: #selector(navigationButtonTapped), for: .touchUpInside)
        
        tableView.snp.makeConstraints { make in
             make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
             make.leading.trailing.bottom.equalToSuperview()
         }
    }
    
    @objc func navigationButtonTapped() {
        self.navigationController?.popViewController(animated: false)
    }
}

extension AlertViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 // 예시로 10개의 셀을 표시
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlertTableViewCell.reuseIdentifier, for: indexPath) as! AlertTableViewCell
        
        // 셀에 데이터 설정
        cell.nameLabel.text = "Friend \(indexPath.row + 1)"
        
        cell.delegate = self
        cell.indexPath = indexPath
        
        return cell
    }
}

extension AlertViewController: AlertTableViewCellDelegate {
    func acceptButtonTapped(at indexPath: IndexPath) {
        // 해당 indexPath에 대한 수락 처리
        print("Accept button tapped at indexPath: \(indexPath)")
    }
    
    func rejectButtonTapped(at indexPath: IndexPath) {
        // 해당 indexPath에 대한 거절 처리
        print("Reject button tapped at indexPath: \(indexPath)")
    }
}
