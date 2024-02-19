//
//  BadgeStatesEnums.swift
//  Wetox-iOS
//
//  Created by Lena on 2/17/24.
//

import Foundation

enum ActivityType: String {
    case book, sns, youtube, game
}

enum TimePeriod: String {
    case day, week, month
}

enum ActivityState {
    case active(ActivityType, TimePeriod)
    case inactive(ActivityType, TimePeriod)
    
    var imageName: String {
        switch self {
            case .active(let type, let period):
                return "\(type.rawValue)-\(period.rawValue)-true"
            case .inactive(let type, let period):
                return "\(type.rawValue)-\(period.rawValue)-false"
        }
    }
}
