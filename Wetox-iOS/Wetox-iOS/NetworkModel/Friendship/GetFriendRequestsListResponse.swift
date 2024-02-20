//
//  getFriendRequestsListResponse.swift
//  Wetox-iOS
//
//  Created by 김소현 on 2/15/24.
//

import Foundation

struct GetFriendRequestsListResponse: Codable {
    let FriendRequestsList: [FriendRequest]
}

struct FriendRequest: Codable {
    let friendshipId: Int64
    let fromUserId: Int64
    let requestedData: Date
}
