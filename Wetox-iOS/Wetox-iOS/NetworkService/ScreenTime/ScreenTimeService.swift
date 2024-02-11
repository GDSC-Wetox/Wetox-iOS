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
}

extension ScreenTimeService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
            case .postCategoryDuration:
                return "/screentime"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .postCategoryDuration:
                return .post
        }
    }
    
    var task: Task {
        switch self {
            case .postCategoryDuration(let data):
                return .requestJSONEncodable(data)
        }
    }
    
    var headers: [String: String]? {
        guard let accessToken = UserDefaults.standard.string(forKey: Const.UserDefaultsKey.accessToken) else {
            return nil
        }
        return ["Content-Type": "application/json", "Authorization": "Bearer \(accessToken)"]
    }
}
