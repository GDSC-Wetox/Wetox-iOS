//
//  acceptFriendshipResponse.swift
//  Wetox-iOS
//
//  Created by 김소현 on 2/15/24.
//

import Foundation

struct AcceptFriendshipResponse: Codable {
    let friendshipId: Int64
    let from: Int64
    let to: Int64
    let createDate: Date
    let requestDate: Date
    let status: String
}

enum FriendshipStatus: String {
    case accept = "ACCEPT"
    case requset = "REQUEST"
}
