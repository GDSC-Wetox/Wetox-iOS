//
//  CategoryDurationResponse.swift
//  Wetox-iOS
//
//  Created by Lena on 2/8/24.
//

import Foundation

struct CategoryDurationResponse: Codable {
    let nickname: String
    let updatedDate: Date
    let totalDuration: Int
    let categoryScreenTimes: [CategoryDurationRequest]
}
