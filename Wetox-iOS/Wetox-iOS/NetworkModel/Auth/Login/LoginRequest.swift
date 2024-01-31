//
//  LoginRequest.swift
//  Wetox-iOS
//
//  Created by 김소현 on 1/26/24.
//

import Foundation

struct LoginRequest: Codable {
    let oauthProvider: String
    let openId: String
}
