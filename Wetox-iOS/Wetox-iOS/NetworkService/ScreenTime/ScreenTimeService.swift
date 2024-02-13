//
//  ScreenTimeService.swift
//  Wetox-iOS
//
//  Created by Lena on 2/8/24.
//

import Foundation
import Moya

enum ScreenTimeService {
    case postCategoryDuration(data: [CategoryDurationRequest])
    case getScreenTime
}

extension ScreenTimeService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
            case .postCategoryDuration, .getScreenTime:
                return "/screentime"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .postCategoryDuration:
                return .post
            case .getScreenTime:
                return .get
        }
    }
    
    var task: Task {
        switch self {
            case .postCategoryDuration(let data):
                return .requestJSONEncodable(data)
            case .getScreenTime:
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
