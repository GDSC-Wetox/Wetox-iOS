//
//  getFriendsListResponse.swift
//  Wetox-iOS
//
//  Created by 김소현 on 2/15/24.
//

import Foundation

struct GetFriendsListResponse: Codable {
    let friendsList: [Friend]
}

struct Friend: Codable {
    let userId: Int64
    let nickname: String
    let totalDuration: Int64
}
