//
//  BadgeAPI.swift
//  Wetox-iOS
//
//  Created by Lena on 2/21/24.
//

import UIKit
import Moya
import RxSwift
import RxMoya

class BadgeAPI {
    
    static let provider = MoyaProvider<BadgeService>(plugins: [MoyaLoggerPlugin()])
    
    static func getBadges() -> Observable<BadgeResponse> {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter().mapDateFormat())
        
        return provider.rx.request(.getBadges)
            .map(BadgeResponse.self, using: decoder)
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
    
    static func updateBadge() -> Observable<BadgeResponse> {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter().mapDateFormat())
        
        return provider.rx.request(.updateBadge)
            .map(BadgeResponse.self, using: decoder)
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
