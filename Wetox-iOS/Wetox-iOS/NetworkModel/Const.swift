//
//  Const.swift
//  Wetox-iOS
//
//  Created by 김소현 on 1/28/24.
//

import Foundation

struct Const {
    
}

extension Const {
    struct URL {
        static let baseURL = "https://api.wetox.dev"
    }
    
    struct Header {
        static var multipartHeader = ["Content-Type": "multipart/form-data"]
    }
}

extension Const {
    struct UserDefaultsKey {
        static let oauthProvider = "oauthProvider"
        static let accessToken = "accessToken"
        static let openId = "openId"
        static let deviceToken = "deviceToken"
        static let updatedAt = "updatedAt"
        static let isLogin = "isLogin"
    }
}
