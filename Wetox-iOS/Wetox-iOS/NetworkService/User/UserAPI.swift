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
}
