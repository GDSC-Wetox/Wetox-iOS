//
//  NetworkErrorUtils.swift
//  Wetox-iOS
//
//  Created by 김소현 on 2/14/24.
//

import Foundation

import KakaoSDKAuth
import RxSwift
import Moya

class NetworkErrorUtils {
    // 전역 함수 호출에 대한 싱글톤 객체
    static let shared = NetworkErrorUtils()
    
    func handleTokenError(error: Error, request: AuthService) -> Observable<TokenResponse> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        if let moyaError = error as? MoyaError, moyaError.response?.statusCode == 401 {
            print("만료된 토큰에 대하여 재발급을 시도합니다.")
            
            let oldToken = UserDefaults.standard.object(forKey: Const.UserDefaultsKey.accessToken)
            
            AuthApi.shared.refreshToken(token: oldToken as? OAuthToken) { newToken, error in
                if let error = error {
                    print("토큰 재발급 실패: \(error.localizedDescription)")
                } else if let newToken = newToken {
                    UserDefaults.standard.setValue(newToken.idToken, forKey: Const.UserDefaultsKey.openId)
                }
            }

            let refreshTokenRequest = TokenRequest(oauthProvider:
                                                    UserDefaults.standard.string(forKey: Const.UserDefaultsKey.oauthProvider) ?? String(), openId: UserDefaults.standard.string(forKey: Const.UserDefaultsKey.openId) ?? String())
            
            return AuthAPI.authProvider.rx.request(.login(tokenRequest: refreshTokenRequest))
                .map(TokenResponse.self, using: decoder)
                .asObservable()
        }
        else {
            return Observable.error(error)
        }
    }
}
