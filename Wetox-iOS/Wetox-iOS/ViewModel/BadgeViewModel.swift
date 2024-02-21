//
//  BadgeViewModel.swift
//  Wetox-iOS
//
//  Created by Lena on 2/21/24.
//

import Foundation
import RxSwift
import RxCocoa

class BadgeViewModel {
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private let badgeAPI = BadgeAPI.self
    
    // Observables exposed to the view
    let badgeList: BehaviorSubject<[Badge]> = BehaviorSubject(value: [])
    let rewardedBadgeNames: BehaviorSubject<[String]> = BehaviorSubject(value: [])
    let isLoading: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    let error: BehaviorSubject<String?> = BehaviorSubject(value: nil)
    
    // MARK: - API Methods
    
    func fetchBadges() {
        isLoading.onNext(true)
        badgeAPI.getBadges()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] badgeResponse in
                self?.isLoading.onNext(false)
                
                // true인 badgeName을 추출
                let rewardedBadges = badgeResponse.badgeList.filter { $0.rewarded }
                let badgeNames = rewardedBadges.map { $0.badgeName }
                
                // 필터링된 배지 이름을 rewardedBadgeNames BehaviorSubject에 전달
                self?.rewardedBadgeNames.onNext(badgeNames)
                
                // 전체 배지 리스트 업데이트
                self?.badgeList.onNext(badgeResponse.badgeList)
                
                // 디버깅을 위한 출력
                print("Rewarded Badge Names: \(badgeNames)")
            } onError: { [weak self] error in
                self?.isLoading.onNext(false)
                self?.error.onNext(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    func updateBadge() {
        isLoading.onNext(true)
        badgeAPI.updateBadge()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] badgeResponse in
                self?.isLoading.onNext(false)
                print("updateBadge의 badgeResponse: \(badgeResponse.badgeList)")
                self?.badgeList.onNext(badgeResponse.badgeList)
            } onError: { [weak self] error in
                self?.isLoading.onNext(false)
                self?.error.onNext(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    // MARK: - Initialization
    
    init() {
        fetchBadges()
    }
}
