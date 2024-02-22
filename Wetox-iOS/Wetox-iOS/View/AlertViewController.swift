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
    var friendRequestsList: [friendshipRequest] = []
    
    private var navigationButton: UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        print("openid")
        print(UserDefaults.standard.string(forKey: Const.UserDefaultsKey.openId)!)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AlertTableViewCell.self, forCellReuseIdentifier: AlertTableViewCell.reuseIdentifier)

        
        self.navigationItem.title = "알림"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: navigationButton)
        
        [navigationButton, tableView].forEach { view.addSubview($0) }
        
        configureLayout()
        getAllFriendshipRequests()
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
        dismiss(animated: true)
    }
}

extension AlertViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendRequestsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlertTableViewCell.reuseIdentifier, for: indexPath) as! AlertTableViewCell
        
        cell.friendRequestLabel.text = "\(friendRequestsList[indexPath.row].fromUserNickname)님의 친구 요청"
        
        cell.delegate = self
        cell.indexPath = indexPath
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension AlertViewController: AlertTableViewCellDelegate {
    func presentAcceptAlertController(at indexPath: IndexPath) {
        let toId = friendRequestsList[indexPath.row].fromUserId
        
        FriendshipAPI.acceptFriendship(toId: toId)
               .subscribe(onNext: { response in
                   print("Friendship request accepted successfully!")
                   print(response.status)

                   let alertController = UIAlertController(title: "친구 추가 완료", message: "친구 요청을 수락하였습니다.", preferredStyle: .alert)
                   alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                   self.present(alertController, animated: true, completion: nil)
                   
               }, onError: { error in
                   print("Error accepting friendship request: \(error.localizedDescription)")
               })
               .disposed(by: disposeBag) 
    }
    
    func presentRejectAlertController(at indexPath: IndexPath) {
        // TODO: 친구 요청 거절 API 추가 구현
        
        let alertController = UIAlertController(title: "친구 요청 거절", message: "친구 요청을 거절하였습니다.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

extension AlertViewController {
    func getAllFriendshipRequests() {
        FriendshipAPI.getAllFriendshipRequest()
            .subscribe(onNext: { [weak self] response in
                print("response \(response)")
                self?.friendRequestsList = response.friendRequestsList
                self?.tableView.reloadData() // Reload table view after fetching friend requests
                print("Friendship requests retrieved successfully!")
            }, onError: { error in
                print("Error getting friendship requests: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
}
