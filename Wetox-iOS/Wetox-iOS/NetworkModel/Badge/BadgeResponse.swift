//
//  BadgeResponse.swift
//  Wetox-iOS
//
//  Created by Lena on 2/21/24.
//

import Foundation

struct BadgeResponse: Codable {
    var badgeList: [Badge]
}

struct Badge: Codable {
    var badgeName: String
    var rewardedDate: Date?
    var rewarded: Bool
}
