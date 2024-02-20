//
//  FriendshipAPI.swift
//  Wetox-iOS
//
//  Created by 김소현 on 2/15/24.
//

import UIKit
import Moya
import RxSwift
import RxMoya

public class FriendshipAPI {
    static let friendshipProvider = MoyaProvider<FriendshipService>(plugins: [MoyaLoggerPlugin()])
    
//    static func requestFriendship(
    
//    static func getUserScreenTime(userId: String) -> Observable<CategoryDurationResponse> {
//        
//        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .formatted(DateFormatter().mapDateFormat())
//
//        return provider.rx.request(.getUserScreenTime(userId: userId))
//            .map(CategoryDurationResponse.self, using: decoder)
//            .asObservable()
//            .catch { error in
//                if let moyaError = error as? MoyaError {
//                    switch moyaError {
//                        case .statusCode(let response):
//                            print("HTTP Status Code: \(response.statusCode)")
//                        case .jsonMapping(let response):
//                            print("JSON Mapping Error for Response: \(response)")
//                        default:
//                            print("Other MoyaError: \(moyaError.localizedDescription)")
//                    }
//                }
//                return Observable.error(error)
//            }
//    }

}
