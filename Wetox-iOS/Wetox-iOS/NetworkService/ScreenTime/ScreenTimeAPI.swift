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
        decoder.dateDecodingStrategy = .formatted(DateFormatter().mapDateFormat())

        return provider.rx.request(.postCategoryDuration(data: data))
            .map(CategoryDurationResponse.self, using: decoder)
            .asObservable()
            .catch { error in
                if let moyaError = error as? MoyaError {
                    switch moyaError {
                    case .statusCode(let response):
                        print("HTTP Status Code: \(response.statusCode)")
                    case .jsonMapping(let response):
                        print("JSON Mapping Error for Response: \(response)")
                    default:
                        print("Other MoyaError: \(moyaError.localizedDescription)")
                    }
                }
                return Observable.error(error)
            }
    }
    
    /// /screentime .get 요청
    static func getScreenTime() -> Observable<CategoryDurationResponse> {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter().mapDateFormat())
        
        return provider.rx.request(.getScreenTime)
            .map(CategoryDurationResponse.self, using: decoder)
            .asObservable()
            .catch { error in
                if let moyaError = error as? MoyaError {
                    switch moyaError {
                        case .statusCode(let response):
                            print("HTTP Status Code: \(response.statusCode)")
                        case .jsonMapping(let response):
                            print("JSON Mapping Error for Response: \(response)")
                        default:
                            print("Other MoyaError: \(moyaError.localizedDescription)")
                    }
                }
                return Observable.error(error)
            }
    }
    
    /// userId를 입력받아 CategoryDurationResponse 타입으로 해당 유저의 스크린타임 사용량을 반환합니다.
    static func getUserScreenTime(userId: String) -> Observable<CategoryDurationResponse> {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter().mapDateFormat())

        return provider.rx.request(.getUserScreenTime(userId: userId))
            .map(CategoryDurationResponse.self, using: decoder)
            .asObservable()
            .catch { error in
                if let moyaError = error as? MoyaError {
                    switch moyaError {
                        case .statusCode(let response):
                            print("HTTP Status Code: \(response.statusCode)")
                        case .jsonMapping(let response):
                            print("JSON Mapping Error for Response: \(response)")
                        default:
                            print("Other MoyaError: \(moyaError.localizedDescription)")
                    }
                }
                return Observable.error(error)
            }
    }
}
