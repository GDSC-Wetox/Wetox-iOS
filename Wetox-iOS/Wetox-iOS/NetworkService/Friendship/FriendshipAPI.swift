//
//  FriendshipAPI.swift
//  Wetox-iOS
//
//  Created by 김소현 on 2/15/24.
//

import UIKit
import Moya
import RxSwift
import RxMoya

public class FriendshipAPI {
    static let friendshipProvider = MoyaProvider<FriendshipService>(plugins: [MoyaLoggerPlugin()])

}
