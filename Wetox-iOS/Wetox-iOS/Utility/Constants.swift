//
//  Constants.swift
//  Wetox-iOS
//
//  Created by Lena on 1/27/24.
//

import Foundation

struct Constants {

    struct Padding {
        static let narrowPadding: CGFloat = 8.0
        static let defaultPadding: CGFloat = 16.0
    }

    struct CornerRadius {
        static let slider: CGFloat = 12.0
    }
    
    struct Common {
        static let doneText = "Done"
    }
    
    struct Time {
        /// 24시간 * 60분
        static let maxMinutes: Int = 1440
        static let minMinutes: Int = 0
    }
    
    struct ScreenTimeInput {
        static let navigationTitle = "스크린타임 입력하기"
        static let titleMessage = "🕐 나의 스크린타임 확인하기"
        static let infoMessage = "설정 > 스크린타임 > 앱 및 사이트 활동 모두 보기 > 카테고리 보기"
        static let timeoverTitleMessage = "🤔 어라라..."
        static let timeoverInfoMessage = "모든 사용시간을 더해 봤더니 24시간이 넘어가요\n입력한 내용을 다시 한 번 확인해주세요!"
    }
    
    struct Text {
        static let bottomSheetTitle = "스크린타임 입력하기"
    }
    
    struct font {
        /// 18
        static let semiTitleSize: Int = 18
        /// 16
        static let contentSize: Int = 16
        /// 14
        static let profileNameSize: Int = 14
        /// 24
        static let emphasisSize: Int = 24
        /// 10
        static let descriptionSize: Int = 10
    }
    
    struct Category {
        /*
        static let categories = [
            "엔터테인먼트", "소셜미디어", "생산성 및 금융", "게임",
            "여행", "정보 및 도서", "유틸리티", "쇼핑 및 음식",
            "교육", "창의력", "건강 및 피트니스", "기타"
        ]
         */
        
        static let categoriesKoreanToEnglish: [String: String] = [
            "엔터테인먼트": "ENTERTAINEMENT",
            "소셜미디어": "SOCIAL_MEDIA",
            "생산성 및 금융": "PRODUCTIVITY_AND_FINANCE",
            "게임": "GAME",
            "여행": "TRAVEL",
            "정보 및 도서": "INFORMATION_AND_BOOK",
            "유틸리티": "UTILITY",
            "쇼핑 및 음식": "SHOPPING_AND_FOOD",
            "교육": "EDUCATION",
            "창의력": "CREATIVITY",
            "건강 및 피트니스": "HEALTH_AND_FEATNESS",
            "기타": "OTHERS"
        ]
        
        static let categories = Array(categoriesKoreanToEnglish.keys)
    }
    
    struct BadgeArrays {
        static let badgeNames: [String] = [ "book", "sns", "youtube", "game"]
        static let isAwards = [true, false]
        static let periods = ["day", "week", "month"]
    }
    
    struct Slider {
        // static let width: CGFloat = 348.0
        static let height: CGFloat = 44.0
    }
    
    struct Image {
        static let sliderTrackImageName = "slider-track-image"
        
        static let bookDayTrue = "book-day-true"
        static let bookWeekTrue = "book-week-true"
        static let bookMonthTrue = "book-month-true"
        static let bookDayFalse = "book-day-false"
        static let bookWeekFalse = "book-week-false"
        static let bookMonthFalse = "book-month-false"
        
        static let snsDayTrue = "sns-day-true"
        static let snsWeekTrue = "sns-week-true"
        static let snsMonthTrue = "sns-month-true"
        static let snsDayFalse = "sns-day-false"
        static let snsWeekFalse = "sns-week-false"
        static let snsMonthFalse = "sns-month-false"
        
        static let youtubeDayTrue = "youtube-day-true"
        static let youtubeWeekTrue = "youtube-week-true"
        static let youtubeMonthTrue = "youtube-month-true"
        static let youtubeDayFalse = "youtube-day-false"
        static let youtubeWeekFalse = "youtube-week-false"
        static let youtubeMonthFalse = "youtube-month-false"
        
        static let gameDayTrue = "game-day-true"
        static let gameWeekTrue = "game-week-true"
        static let gameMonthTrue = "game-month-true"
        static let gameDayFalse = "game-day-false"
        static let gameWeekFalse = "game-week-false"
        static let gameMonthFalse = "game-month-false"
        
        static let segmentIcons = ["daily-unselected-icon", "weekly-unselected-icon", "badge-unselected-icon"]
        static let selectedSegmentIcons = ["daily-selected-icon", "weekly-selected-icon", "badge-selected-icon"]
    }
    
    
}
