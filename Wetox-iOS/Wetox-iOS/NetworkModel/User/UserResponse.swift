//
//  UserResponse.swift
//  Wetox-iOS
//
//  Created by Lena on 2/12/24.
//

import Foundation

struct UserResponse: Codable {
    let userId: Int64
    let nickname: String
    let profileImage: String
}
