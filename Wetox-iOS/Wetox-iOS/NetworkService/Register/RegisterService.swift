//
//  RegisterService.swift
//  Wetox-iOS
//
//  Created by 김소현 on 2/21/24.
//

import Foundation
import Moya

enum RegisterService {
    case postNicknameValidRequest(nickname: NicknameValidRequest)
    case getAIImage
}

extension RegisterService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
            case .postNicknameValidRequest:
                return "/auth/valid/nickname"
            case .getAIImage:
                return "/ai/image/profile"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .postNicknameValidRequest:
                return .post
            case .getAIImage:
                return .get
        }
    }
    
    var task: Task {
        switch self {
            case .postNicknameValidRequest(let data):
                return .requestJSONEncodable(data)
            case .getAIImage:
                return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return .none
    }
}
