//
//  SocialSignUpRequest.swift
//  Wetox-iOS
//
//  Created by 김소현 on 1/26/24.
//

import Foundation

struct SocialSignUpRequest: Codable {
    let OpenID: String
    let nickname: String
    let socialType: String
    let profileImageURL: String
}
