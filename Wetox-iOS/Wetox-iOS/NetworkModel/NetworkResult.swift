//
//  NetworkResult.swift
//  Wetox-iOS
//
//  Created by 김소현 on 1/28/24.
//

import Foundation

/**

 NetworkResult<T>

 - success: 서버 통신 성공
 - requestError: 요청 에러 발생
 - pathError: 경로 에러
 - serverError: 서버 내부적 에러
 - networkFail: 네트워크 연결 실패
 
 */

enum NetworkResult<T> {
    case success(T)
    case requestError(T, T)
    case pathError
    case serverError
    case networkFail
}
