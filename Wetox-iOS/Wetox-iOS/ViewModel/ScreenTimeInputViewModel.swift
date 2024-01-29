//
//  ScreenTimeInputViewModel.swift
//  Wetox-iOS
//
//  Created by Lena on 1/28/24.
//

import Foundation

import RxSwift
import RxCocoa

class ScreenTimeInputViewModel {
    
    let totalSliderValue: Observable<Float>
    var isExceededSubject = BehaviorSubject<Bool>(value: false)
    
    /** ScreenTimeInputView에서 선택하는 각 category 들의 총 합이 24시간을 넘지 않는지 체크
     */
    var isExceeded: Observable<Bool> {
        return isExceededSubject.asObservable()
    }
    
    init(sliderValues: [Observable<Float>]) {
        totalSliderValue = Observable.combineLatest(sliderValues) {
            $0.reduce(0, +)
        }
        
        isExceededSubject = BehaviorSubject<Bool>(value: false)
        
        _ = totalSliderValue.map { $0 > 1440 }
            .bind(to: isExceededSubject)
    }
}
