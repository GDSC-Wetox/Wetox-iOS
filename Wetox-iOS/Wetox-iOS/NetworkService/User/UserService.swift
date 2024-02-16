//
//  UserService.swift
//  Wetox-iOS
//
//  Created by Lena on 2/12/24.
//

import Foundation
import Moya

enum UserService {
    case getUserInfo
    case nicknameSearch
}

extension UserService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
            case .getUserInfo:
                return "/user/profile"
            case .nicknameSearch:
                return "user/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .getUserInfo, .nicknameSearch:
                return .get
        }
    }
    
    var task: Task {
        switch self {
            case .getUserInfo:
                return .requestPlain
            case .nicknameSearch:
                // TODO: 수정 need
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
