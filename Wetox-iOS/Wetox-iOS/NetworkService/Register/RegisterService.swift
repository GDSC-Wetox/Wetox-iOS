//
//  RegisterService.swift
//  Wetox-iOS
//
//  Created by 김소현 on 2/21/24.
//

import Foundation
import Moya

enum RegisterService {
    case postNicknameCheck
    case getAIImage
}

extension RegisterService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
            case .postNicknameCheck:
                return "/auth/valid/nickname"
            case .getAIImage:
                return "/ai/image/profile"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .postNicknameCheck:
                return .post
            case .getAIImage:
                return .get
        }
    }
    
    var task: Task {
        switch self {
            case .postNicknameCheck:
                return .requestJSONEncodable()
            case .getAIImage:
                return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return .none
    }
}
