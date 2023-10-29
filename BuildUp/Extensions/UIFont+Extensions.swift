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
    case extraBold
    case black
    case semiBold
    case medium
    case light
}

enum FontName {
    case poppins
    case montserrat
}

extension UIFont {
    
    class func appFont(ofSize: CGFloat, weight: FontWeight) -> UIFont {
        
        var fontName: FontName = .poppins
        if let themeData = CachingService.getThemeData() {
            if themeData.font == "Montserrat" {
                fontName = .montserrat
            }
        }
        
        switch fontName {
        case .poppins:
            return setupPoppinsFont(ofSize: ofSize, weight: weight)
        case .montserrat:
            return setupMontserratFont(ofSize: ofSize, weight: weight)
        }
        
//        if (LocalizationManager.currentLanguage().appLanguageCode == Language.arabic.rawValue) {
//            return setupPoppinsFont(ofSize: ofSize, weight: weight)
//        } else {
//            return setupMontserratFont(ofSize: ofSize, weight: weight)
//         }
    }
    
    class func setupPoppinsFont(ofSize: CGFloat, weight: FontWeight) -> UIFont {
        switch weight {
        case .regular:
            return UIFont(name: "Poppins-Regular", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        case .black:
            return UIFont(name: "Poppins-Black", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        case .semiBold:
            return UIFont(name: "Poppins-SemiBold", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        case .bold:
            return UIFont(name: "Poppins-Bold", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        case .extraBold:
            return UIFont(name: "Poppins-ExtraBold", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        case .medium:
            return UIFont(name: "Poppins-Medium", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        case .light:
            return UIFont(name: "Poppins-Light", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        }
    }
    
    class func setupMontserratFont(ofSize: CGFloat, weight: FontWeight) -> UIFont {
        switch weight {
        case .regular:
            return UIFont(name: "Montserrat-Regular", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        case .black:
            return UIFont(name: "Montserrat-Black", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        case .semiBold:
            return UIFont(name: "Montserrat-SemiBold", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        case .bold:
            return UIFont(name: "Montserrat-Bold", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        case .extraBold:
            return UIFont(name: "Montserrat-ExtraBold", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        case .medium:
            return UIFont(name: "Montserrat-Medium", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        case .light:
            return UIFont(name: "Montserrat-Light", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        }
    }
}
