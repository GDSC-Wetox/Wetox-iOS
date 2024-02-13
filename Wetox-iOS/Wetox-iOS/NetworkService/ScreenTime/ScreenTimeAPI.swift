//
//  ScreenTimeAPI.swift
//  Wetox-iOS
//
//  Created by Lena on 2/8/24.
//

import Foundation

import Moya
import RxSwift
import RxMoya

class ScreenTimeAPI {
    static let provider = MoyaProvider<ScreenTimeService>(plugins: [MoyaLoggerPlugin()])
    
    /// CategoryDuration 데이터를 post 요청
    static func postCategoryDuration(data: [CategoryDurationRequest]) -> Observable<CategoryDurationResponse> {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        return provider.rx.request(.postCategoryDuration(data: data))
            .map(CategoryDurationResponse.self, using: decoder)
            .asObservable()
            .catch { error in
                if let moyaError = error as? MoyaError {
                    switch moyaError {
                    case .statusCode(let response):
                        // HTTP 상태 코드에 따른 처리
                        print("HTTP Status Code: \(response.statusCode)")
                    case .jsonMapping(let response):
                        // JSON 매핑 에러 처리
                        print("JSON Mapping Error for Response: \(response)")
                    default:
                        // 기타 Moya 에러 처리
                        print("Other MoyaError: \(moyaError.localizedDescription)")
                    }
                }
                return Observable.error(error) // 원래의 에러를 다시 방출
            }
    }
    
    /// /screentime .get 요청
    static func getScreenTime() -> Observable<CategoryDurationResponse> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        return provider.rx.request(.getScreenTime)
            .map(CategoryDurationResponse.self, using: decoder)
            .asObservable()
            .catch { error in
                if let moyaError = error as? MoyaError {
                    switch moyaError {
                        case .statusCode(let response):
                            // HTTP 상태 코드에 따른 처리
                            print("HTTP Status Code: \(response.statusCode)")
                        case .jsonMapping(let response):
                            // JSON 매핑 에러 처리
                            print("JSON Mapping Error for Response: \(response)")
                        default:
                            // 기타 Moya 에러 처리
                            print("Other MoyaError: \(moyaError.localizedDescription)")
                    }
                }
                return Observable.error(error)
            }
    }
}
