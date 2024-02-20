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
        // TODO: API로 유동적으로 가져오기
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlertTableViewCell.reuseIdentifier, for: indexPath) as! AlertTableViewCell
        
        // 셀에 데이터 설정
        cell.friendRequestLabel.text = "Friend \(indexPath.row + 1)"
        
        cell.delegate = self
        cell.indexPath = indexPath
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension AlertViewController: AlertTableViewCellDelegate {
    func presentAcceptAlertController() {
        let alertController = UIAlertController(title: "친구 추가 완료", message: "친구 요청을 수락하였습니다.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func presentRejectAlertController() {
        let alertController = UIAlertController(title: "친구 요청 거절", message: "친구 요청을 거절하였습니다.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
