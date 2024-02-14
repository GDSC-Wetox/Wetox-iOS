//
//  ScreenTimeInputViewModel.swift
//  Wetox-iOS
//
//  Created by Lena on 1/28/24.
//

import Foundation

import Moya
import RxSwift
import RxCocoa
import RxMoya

class ScreenTimeInputViewModel {
    
    let totalSliderValue: Observable<Float>
    var sliderValues: [Observable<Float>]
    var isExceededSubject = BehaviorSubject<Bool>(value: false)
    let disposeBag = DisposeBag()
    
    /// ScreenTimeInputView에서 선택하는 각 category 들의 총 합이 24시간을 넘지 않는지 체크
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
        
        self.sliderValues = sliderValues
    }
    
    /// 사용자가 입력하는 해당 category의 duration을 서버로 post 합니다
    func postScreenTimeData() {
        Observable.zip(sliderValues) { values in
            return values.enumerated().map { index, value in
                let koreanCategoryName = Constants.Category.categories[index]
                let englishCategoryName = Constants.Category.categoriesKoreanToEnglish[koreanCategoryName] ?? "OTHERS"
                return CategoryDurationRequest(category: englishCategoryName, duration: Int(value))
            }
        }
        .flatMapLatest { categoryDurations in
            ScreenTimeAPI.postCategoryDuration(data: categoryDurations)
        }
        .observe(on: MainScheduler.instance)
        .subscribe(onNext: { response in
            print("ScreenTimeInputViewModel에서 post 성공")
            print("response: \(response.nickname), \(response.updatedDate), \(response.totalDuration), \(response.categoryScreenTimes)")
        }, onError: { error in
            print("viewmodel error: \(error.localizedDescription)")
        })
        .disposed(by: disposeBag)
    }
}
