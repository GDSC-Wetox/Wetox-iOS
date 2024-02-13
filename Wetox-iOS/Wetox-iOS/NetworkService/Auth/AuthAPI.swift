//
//  AuthAPI.swift
//  Wetox-iOS
//
//  Created by 김소현 on 1/28/24.
//

import UIKit
import Moya
import RxSwift
import RxMoya

public class AuthAPI {
    static let authProvider = MoyaProvider<AuthService>(plugins: [MoyaLoggerPlugin()])
    
    static func register(registerRequest: RegisterRequest, profileImage: UIImage?) -> Observable<RegisterResponse> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        return AuthAPI.authProvider.rx.request(.register(registerRequest: registerRequest, profileImage: profileImage))
            .map(RegisterResponse.self, using: decoder)
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
    
    static func login(tokenRequest: TokenRequest) -> Observable<TokenResponse> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        return AuthAPI.authProvider.rx.request(.login(tokenRequest: tokenRequest))
            .map(TokenResponse.self, using: decoder)
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
