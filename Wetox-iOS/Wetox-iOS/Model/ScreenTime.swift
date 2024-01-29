//
//  ScreenTimeModel.swift
//  Wetox-iOS
//
//  Created by Lena on 1/27/24.
//

import Foundation

/// 사용자의 화면 시간에 대한 정보를 담습니다
struct UserScreenTime: Codable {
    var nickname: String
    var updatedDate: Date
    var totalDuration: Double
    var categoryScreenTimes: [CategoryScreenTime]
}

/// 각 카테고리 스크린타임에 대한 정보를 담습니다
struct CategoryScreenTime: Codable {
    var category: String
    var duration: Double // 분 단위
    
    /// 분 단위의 duration을 "HH시간 mm분" 형식의 문자열로 변환하여 반환하는 메소드
    var durationInHoursAndMinutes: String {
        let hours = Int(duration / 60)
        let minutes = Int(duration.truncatingRemainder(dividingBy: 60))
        return "\(hours)시간 \(minutes)분"
    }
}

/// 날짜 및 시간을 처리하기 위한 Extension 입니다.
extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ" // ISO8601 형식
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

/// JSON 데이터를 디코딩하는 데 사용할 Decoder를 구성하는 확장
extension JSONDecoder {
    static let iso8601Full: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        return decoder
    }()
}

/// JSON 데이터를 인코딩하는 데 사용할 Encoder를 구성하는 확장
extension JSONEncoder {
    static let iso8601Full: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(DateFormatter.iso8601Full)
        return encoder
    }()
}
