//
//  RegisterAPI.swift
//  Wetox-iOS
//
//  Created by 김소현 on 2/21/24.
//

import UIKit
import Moya
import RxSwift
import RxMoya

public class RegisterAPI {
    static let registerProvider = MoyaProvider<RegisterService>(plugins: [MoyaLoggerPlugin()])
    
    static func postNicknameValidRequest(nickname: NicknameValidRequest) -> Observable<NicknameValidResponse> {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter().mapDateFormat())
        
        return registerProvider.rx.request(.postNicknameValidRequest(nickname: nickname))
            .map(NicknameValidResponse.self, using: decoder)
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
    
    static func getAIProfileImage() -> Observable<Data> {
            return registerProvider.rx.request(.getAIImage)
                .map { response -> Data in
                    print("response")
                    print(response.data)
                    return response.data
                }
                .asObservable()
                .catch { error in
                    if let moyaError = error as? MoyaError {
                        switch moyaError {
                        case .statusCode(let response):
                            print("HTTP Status Code: \(response.statusCode)")
                        default:
                            print("Other MoyaError: \(moyaError.localizedDescription)")
                        }
                    }
                    return Observable.error(error)
                }
        }
}
