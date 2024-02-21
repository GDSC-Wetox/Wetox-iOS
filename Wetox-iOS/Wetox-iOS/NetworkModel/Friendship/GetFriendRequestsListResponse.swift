//
//  getFriendRequestsListResponse.swift
//  Wetox-iOS
//
//  Created by 김소현 on 2/15/24.
//

import Foundation

struct GetFriendRequestsListResponse: Codable {
    let friendRequestsList: [friendshipRequest]
}

struct friendshipRequest: Codable {
    let friendshipId: Int64
    let fromUserId: Int64
    let fromUserNickname: String
    let requestedDate: Date
}
