//
//  TokenRequest.swift
//  Wetox-iOS
//
//  Created by 김소현 on 1/26/24.
//

import Foundation

struct TokenRequest: Codable {
    let oauthProvider: String
    let openId: String
}
