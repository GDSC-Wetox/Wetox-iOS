//
//  FriendshipService.swift
//  Wetox-iOS
//
//  Created by 김소현 on 2/15/24.
//

import Foundation
import Moya

enum FriendshipService {
    case requestFriendship(toId: String)
    case acceptFriendship(toId: String)
    case getFriendsList
    case getFriendRequestsList
}

extension FriendshipService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .requestFriendship(let toId):
            return "/friendship/request/\(toId)"
        case .acceptFriendship(let toId):
            return "/friendship/accept/\(toId)"
        case .getFriendsList:
            return "/frienship"
        case .getFriendRequestsList:
            return "/friendship/request"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .requestFriendship, .acceptFriendship:
            return .post
        case .getFriendsList, .getFriendRequestsList:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .requestFriendship, .acceptFriendship, .getFriendsList, .getFriendRequestsList:
                return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        guard let accessToken = UserDefaults.standard.string(forKey: Const.UserDefaultsKey.accessToken) else {
            return nil
        }
        return ["Content-Type": "application/json", "Authorization": "Bearer \(accessToken)"]
    }
}
