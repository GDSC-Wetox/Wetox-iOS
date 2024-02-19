//
//  NicknameSearchResponse.swift
//  Wetox-iOS
//
//  Created by 김소현 on 2/18/24.
//

import Foundation

struct NicknameSearchResponse: Codable {
    let userId: Int64
    let nickname: String
    let profileImage: String
}
