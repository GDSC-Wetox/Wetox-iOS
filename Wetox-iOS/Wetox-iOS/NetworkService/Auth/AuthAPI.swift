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
    
    // MARK: - 소셜 회원가입
    func socialSignUp(socialSignUpRequest: SocialSignUpRequest, profileImage: UIImage?, completion: @escaping (NetworkResult<Any>) -> Void) {
        authProvider.request(.socialSignUp(SocialSignUpRequest: socialSignUpRequest, profileImage: profileImage)) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeSocialSignUpStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    // MARK: - 로그인
    func login(loginRequest: LoginRequest, completion: @escaping (NetworkResult<Any>) -> Void) {
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
    
    // MARK: - 로그아웃
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
    
    // MARK: - 회원 탈퇴
    func withdrawal(completion: @escaping (NetworkResult<Any>) -> Void) {
        authProvider.request(.withdrawal) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeWithdrawalStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    private func judgeSocialSignUpStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<SocialSignUpResponse>.self, from: data) else { return .pathError }
        
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
        guard let decodedData = try? decoder.decode(GenericResponse<LoginResponse>.self, from: data) else { return .pathError }
        
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
    
    private func judgeWithdrawalStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<String>.self, from: data) else { return .pathError }
        
        switch statusCode {
        case 200:
            return .success(decodedData)
        case 400..<500:
            return .requestError(decodedData.resultCode, decodedData.message)
        case 500:
            return .serverError
        default:
            return .networkFail
        }
    }
}
