//
//  MainViewModel.swift
//  Wetox-iOS
//
//  Created by Lena on 2/11/24.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel {
    
    let disposeBag = DisposeBag()
    
    let myProfile: Observable<(nickname: String, imageName: String)>
    
    init(userAPI: UserAPI = .init()) {
        myProfile = UserAPI.getUserInfo()
            .map { ($0.nickname, $0.profileImage) }
            .catch { _ in Observable.just(("unknown", "person")) }
            .share(replay: 1, scope: .whileConnected)
    }
}
