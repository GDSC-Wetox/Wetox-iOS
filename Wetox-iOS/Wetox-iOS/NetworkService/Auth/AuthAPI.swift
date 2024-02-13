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
                handleTokenError(error: error, request: .login(tokenRequest: tokenRequest))
        }
    }
    
    static func handleTokenError<T>(error: Error, request: AuthService) -> Observable<T> {
        if let moyaError = error as? MoyaError, moyaError.response?.statusCode == 401 {
            // 토큰 관련 오류 (예: 만료) 발생 시 재발급 로직 수행
            // 토큰 재발급 로직에 따라 새로운 토큰을 얻고 해당 request를 재시도합니다.
            // 여기서는 예시로 새로운 토큰을 요청하는 로직을 작성했습니다.
            
            // 새로운 토큰을 가져오는 로직 (예: refreshToken 사용 등)
            // 토큰을 가져오는 비동기 작업을 Observable로 wrapping
            
            // 여기서는 예시로 에러를 방출하지 않고, 빈 Observable을 반환합니다.
            print("토큰 재발급")
            return Observable.empty()
        } else {
            // 다른 유형의 에러인 경우, 해당 에러를 그대로 방출합니다.
            return Observable.error(error)
        }
    }
}
