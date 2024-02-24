//
//  Language
//  BuildUp
//
//  Created by Mohammed Khaled on 20/05/2023.
//

import UIKit

enum Language: String {
    
    case arabic = "ar"
    case english = "en"
    
//    var languageCode: String {
//        
//        switch self {
//        case .arabic: return "ar"
//        case .english: return "en"
//        case .persian: return "fa"
//        case .french: return "fr"
//        case .russian: return "ru"
//        case .chineese: return "zh-Hans"
//        case .undefined: return "en"
//        }
//    }
//    
//    var languageTag: String {
//        
//        switch self {
//        case .arabic: return "ar-SA"
//        case .english: return "en-US"
//        case .persian: return "fa-FA"
//        case .french: return "fr-FR"
//        case .russian: return "ru-RU"
//        case .chineese: return "zh-CN"
//        case .undefined: return "undefined"
//        }
//    }
    
    var languageName: String {
        
        switch self {
        case .arabic: return "العربية"
        case .english: return "English"
        }
    }
}
