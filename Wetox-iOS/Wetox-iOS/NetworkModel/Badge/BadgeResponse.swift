//
//  BadgeResponse.swift
//  Wetox-iOS
//
//  Created by Lena on 2/21/24.
//

import Foundation

struct BadgeResponse: Codable {
    let badgeList: [Badge]
}

struct Badge: Codable {
    let badgeName: String
    let rewardedDate: Date?
    let rewarded: Bool
}
