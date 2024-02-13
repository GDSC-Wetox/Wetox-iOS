//
//  DateFormatter+Extension.swift
//  Wetox-iOS
//
//  Created by Lena on 2/13/24.
//

import Foundation

extension DateFormatter {
    func mapDateFormat() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSSS"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        return dateFormatter
    }
}
