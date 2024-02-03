//
//  AuthService.swift
//  Wetox-iOS
//
//  Created by 김소현 on 1/28/24.
//

import UIKit
import Moya

enum AuthService {
    case register(registerRequest: RegisterRequest, profileImage: UIImage?)
    case login(loginRequest: TokenRequest) // 로그인
    case logout // 로그아웃
}

extension AuthService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .register:
            return "/auth/register"
        case .login:
            return "/auth/login"
        case .logout:
            return "/auth/logout"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .register, .login, .logout:
            return .post
        }
    }
    
    /// MultipartFormData - Image 전송
    var task: Moya.Task {
        switch self {
        case .register(let registerRequest, let profileImage):
            var multipartFormData: [MultipartFormData] = []
            
            let requestData = try? JSONEncoder().encode(registerRequest)
            multipartFormData.append(MultipartFormData(provider: .data(requestData!), name: "socialSignUpRequest", mimeType: "application/json"))
            if profileImage != nil {
                let imageData = profileImage!.jpegData(compressionQuality: 1.0)
                multipartFormData.append(MultipartFormData(provider: .data(imageData!), name: "profileImage", fileName: "image.jpg", mimeType: "image/gif"))
            }
            
            return .uploadMultipart(multipartFormData)
            
        case .login(let loginRequest):
            return .requestJSONEncodable(loginRequest)
            
        case .logout:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .register:
            return Const.Header.multipartHeader
        case .login:
            return .none
        case .logout:
            let sessionId = ""
            // UserDefaults.standard.string(forKey: Const.UserDefaultsKey.sessionId)
            let authorizationHeader = ["Content-Type": "application/json", "Authorization": sessionId]
            return authorizationHeader
        }
    }
}
