//
//  RegisterAPI.swift
//  Wetox-iOS
//
//  Created by 김소현 on 2/21/24.
//

import UIKit
import Moya
import RxSwift
import RxMoya

public class RegisterAPI {
    static let registerProvider = MoyaProvider<RegisterService>(plugins: [MoyaLoggerPlugin()])
    
}
