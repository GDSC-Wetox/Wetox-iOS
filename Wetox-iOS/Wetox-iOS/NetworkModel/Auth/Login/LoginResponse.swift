//
//  LoginResponse.swift
//  Wetox-iOS
//
//  Created by 김소현 on 1/26/24.
//

import Foundation

// 수정 Need 
struct LoginResponse: Codable {
    let sessionId: String
    let memberId: Int
}