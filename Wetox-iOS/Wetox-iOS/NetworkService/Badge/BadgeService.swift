//
//  BadgeService.swift
//  Wetox-iOS
//
//  Created by Lena on 2/21/24.
//

import Foundation
import Moya

enum BadgeService {
    case getBadges
    case updateBadge
}

extension BadgeService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }

    var path: String {
        switch self {
        case .getBadges, .updateBadge:
            return "/badge"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getBadges:
            return .get
        case .updateBadge:
            return .post
        }
    }

    var task: Task {
        switch self {
            case .getBadges, .updateBadge:
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
