//
//  UIFont+Extensions.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 20/05/2023.
//

import Foundation
import UIKit

enum FontWeight {
    case regular
    case bold
    case black
    case semiBold
    case light
}

extension UIFont {
    
    class func appFont(ofSize: CGFloat, weight: FontWeight) -> UIFont {
        if (LocalizationManager.currentLanguage().appLanguageCode == Language.arabic.rawValue) {
            return setupArabicFont(ofSize: ofSize, weight: weight)
        } else {
            return setupEnglishFont(ofSize: ofSize, weight: weight)
        }
    }
    
    class func setupEnglishFont(ofSize: CGFloat, weight: FontWeight) -> UIFont {
        switch weight {
        case .regular:
            return UIFont(name: "NotoSansMyanmar-Regular", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        case .black:
            return UIFont.systemFont(ofSize: ofSize)
        case .semiBold:
            return UIFont(name: "NotoSansMyanmar-Bold", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        case .bold:
            return UIFont(name: "NotoSansMyanmar-Bold", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        case .light:
            return UIFont(name: "NotoSansMyanmar-Light", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        }
    }
    
    class func setupArabicFont(ofSize: CGFloat, weight: FontWeight) -> UIFont {
        switch weight {
        case .regular:
            return UIFont(name: "NotoSansMyanmar-Regular", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        case .black:
            return UIFont.systemFont(ofSize: ofSize)
        case .semiBold:
            return UIFont(name: "NotoSansMyanmar-Bold", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        case .bold:
            return UIFont(name: "NotoSansMyanmar-Bold", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        case .light:
            return UIFont(name: "NotoSansMyanmar-Light", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        }
    }
}
