//
//  RegisterRequest.swift
//  Wetox-iOS
//
//  Created by 김소현 on 1/26/24.
//

import Foundation

struct RegisterRequest: Codable {
    let nickname: String
    let oauthProvider: String
    let openId: String
    let deviceToken: String
}
