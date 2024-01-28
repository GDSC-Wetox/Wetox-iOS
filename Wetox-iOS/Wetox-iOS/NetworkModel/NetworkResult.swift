//
//  NetworkResult.swift
//  Wetox-iOS
//
//  Created by 김소현 on 1/28/24.
//

import Foundation

enum NetworkResult<T> {
    case success(T) // 서버 통신 성공
    case requestError(T, T) // 요청 에러 발생
    case pathError // 경로 에러
    case serverError // 서버 내부적 에러
    case networkFail // 네트워크 연결 실패
}
