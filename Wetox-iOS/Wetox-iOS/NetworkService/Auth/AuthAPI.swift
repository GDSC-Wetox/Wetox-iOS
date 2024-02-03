//
//  AuthAPI.swift
//  Wetox-iOS
//
//  Created by 김소현 on 1/28/24.
//

import UIKit
import Moya

public class AuthAPI {
    static let shared = AuthAPI()
    var authProvider = MoyaProvider<AuthService>(plugins: [MoyaLoggerPlugin()])
    
    public init() { }
    
    // MARK: - 회원가입
    func register(registerRequest: RegisterRequest, profileImage: UIImage?, completion: @escaping (NetworkResult<Any>) -> Void) {
        authProvider.request(.register(registerRequest: registerRequest, profileImage: profileImage)) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeRegisterStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    func login(loginRequest: TokenRequest, completion: @escaping (NetworkResult<Any>) -> Void) {
        authProvider.request(.login(loginRequest: loginRequest)) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeLoginStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    func logout(completion: @escaping (NetworkResult<Any>) -> Void) {
        authProvider.request(.logout) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeLoginStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    private func judgeRegisterStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<RegisterResponse>.self, from: data) else { return .pathError }
        
        switch statusCode {
        case 200:
            return .success(decodedData.data ?? "None-data")
        case 400..<500:
            return .requestError(decodedData.resultCode, decodedData.message)
        case 500:
            return .serverError
        default:
            return .networkFail
        }
    }
    
    private func judgeLoginStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<TokenResponse>.self, from: data) else { return .pathError }
        
        switch statusCode {
        case 200:
            return .success(decodedData.data ?? "None-data")
        case 400..<500:
            return .requestError(decodedData.resultCode, decodedData.message)
        case 500:
            return .serverError
        default:
            return .networkFail
        }
    }
    
    private func judgeLogoutStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<String>.self, from: data) else { return .pathError }
        
        switch statusCode {
        case 200:
            return .success(decodedData.data ?? "None-data")
        case 400..<500:
            return .requestError(decodedData.resultCode, decodedData.message)
        case 500:
            return .serverError
        default:
            return .networkFail
        }
    }
}
