//
//  TimeConverter.swift
//  Wetox-iOS
//
//  Created by Lena on 1/28/24.
//

import Foundation

struct TimeConverter {
    
    /// "분" 단위를 입력받아 "~시 ~분" 형식으로 출력해줍니다
    static func convertMinutesToHoursAndMinutes(_ minutes: Int) -> String {
        switch minutes {
        case 0:
            return "0분"
        case 1...59:
            return "\(minutes)분"
        default:
            let hours = minutes / 60
            let remainingMinutes = minutes % 60
            var result = "\(hours)시간"
            if remainingMinutes > 0 {
                result += " \(remainingMinutes)분"
            }
            return result
        }
    }
}
