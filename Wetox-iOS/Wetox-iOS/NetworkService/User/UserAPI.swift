//
//  UserAPI.swift
//  Wetox-iOS
//
//  Created by Lena on 2/12/24.
//

import Foundation
import Moya
import RxSwift
import RxMoya

class UserAPI {
    
    static let provider = MoyaProvider<UserService>(plugins: [MoyaLoggerPlugin()])
    var disposeBag = DisposeBag()
    var userInfo = PublishSubject<UserResponse>()
    
    /// /user/profile .get 요청
    static func getUserInfo() -> Observable<UserResponse> {
        let decoder = JSONDecoder()
        
        return provider.rx.request(.getUserInfo)
            .map(UserResponse.self, using: decoder)
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
    
    static func nicknameSearch(data: NicknameSearchRequest) -> Observable<NicknameSearchResponse> {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter().mapDateFormat())
        
        return provider.rx.request(.nicknameSearch(data: data))
            .map(NicknameSearchResponse.self, using: decoder)
            .asObservable()
            .do(onNext: { response in
                // 서버 응답 데이터 출력
                print("Server response data: \(response)")
            }, onError: { error in
                // 에러 발생 시 서버 응답 데이터 출력
                if let response = (error as? MoyaError)?.response {
                    print("Server error response data: \(response)")
                }
            })
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
