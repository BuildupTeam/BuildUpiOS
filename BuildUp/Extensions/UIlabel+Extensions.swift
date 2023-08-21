//
//  UIlabel+Extensions.swift
//  flyers
//
//  Created by Mahmoud Nasser on 26/09/2022.
//

import Foundation
import UIKit

extension UILabel {
    
    func setPrice(price: Int) {
        
        let actualPrice = price
        
        let formatter = Formatters()
        var priceString: String = ""
        
        if LocalizationManager.currentLanguage().appLanguageCode == Language.english.rawValue {
            
            if actualPrice <= 99_999 && actualPrice > 0 {
                priceString = "\(actualPrice)"
            } else if actualPrice > 99_999 && actualPrice <= 999_999 {
                let priceK: Int = actualPrice / 1000
                priceString = "\(priceK) K"
            } else {
                priceString = "--"
            }
        } else {
            
            if actualPrice <= 99_999 && actualPrice > 0 {
                priceString = formatter.localizeNumber(toArabic: actualPrice )
            } else if actualPrice > 99_999 && actualPrice <= 999_999 {
                let priceK: Int = actualPrice / 1000
                priceString = formatter.localizeNumber(toArabic: priceK) + "الف"
            } else {
                priceString = "--"
            }
        }
        
        self.text = priceString
    }
}

extension UILabel {
    func setUnderLinedText(text: String, font: UIFont, color: UIColor) {
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.underlineStyle: 1,
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: color]

        let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
        self.attributedText = attributedString
    }
}

extension UILabel {
    func setColorForSubText(font: UIFont, mainColor: UIColor, rangeColor: UIColor, mainText: String, textToColor1: String, textToColor2: String? = nil) {
        let colorRange1 = (mainText as NSString).range(of: textToColor1)
        let mainRange = (mainText as NSString).range(of: mainText)

        let attributedString = NSMutableAttributedString(string: mainText)
        
        attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: mainRange)
        
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: mainColor, range: mainRange)
        
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: rangeColor, range: colorRange1)
    
        if let textToColor2 = textToColor2 {
            let colorRange2 = (mainText as NSString).range(of: textToColor2)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: rangeColor, range: colorRange2)
        }
        
        self.attributedText = attributedString
    }
}
