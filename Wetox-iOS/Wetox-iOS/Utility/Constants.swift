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
        static let maxMinutes = 1440
        static let minMinutes = 0
    }
    
    struct ScreenTimeInput {
        static let navigationTitle = "스크린타임 입력하기"
        static let titleMessage = "🕐 나의 스크린타임 확인하기"
        static let infoMessage = "설정 > 스크린타임 > 앱 및 사이트 활동 모두 보기 > 카테고리 보기"
        static let timeoverTitleMessage = "🤔 어라라..."
        static let timeoverInfoMessage = "모든 사용시간을 더해 봤더니 24시간이 넘어가요\n입력한 내용을 다시 한 번 확인해주세요!"
    }
    
    struct font {
        static let semiTitleSize: Int = 18
        static let contentSize: Int = 16
        static let profileNameSize: Int = 14
        static let emphasisSize: Int = 24
        static let descriptionSize: Int = 10
            }
    
    struct Category {
        static let categories = [
            "엔터테인먼트", "소셜미디어", "생산성 및 금융", "게임",
            "여행", "정보 및 도서", "유틸리티", "쇼핑 및 음식",
            "교육", "창의력", "건강 및 피트니스", "기타"
        ]
    }
    
    struct Slider {
        // static let width: CGFloat = 348.0
        static let height: CGFloat = 44.0
    }
    
    struct Image {
        static let sliderTrackImageName = "slider-track-image"
    }
}
