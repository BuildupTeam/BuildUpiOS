//
//  UIlabel+Extensions.swift
//  BuildUp
//
//  Created by Mohamed Khaled on 14/09/2023.
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
    
    func addTrailing(with trailingText: String, moreText: String, moreTextFont: UIFont, moreTextColor: UIColor) {
        let readMoreText: String = trailingText + moreText
        
        let lengthForVisibleString: Int = self.vissibleTextLength
        let mutableString: String = self.text!
        var trimmedString: String? = (mutableString as NSString).replacingCharacters(in: NSRange(location: lengthForVisibleString, length: ((self.text?.count)! - lengthForVisibleString)), with: "")
        let readMoreLength: Int = (readMoreText.count)
        
        if ((trimmedString?.contains("\n")) != nil) {
            trimmedString = trimmedString?.replacingOccurrences(of: "\n", with: " ")
        }
        
        let location = (trimmedString?.count ?? 0) - readMoreLength
        
        let trimmedForReadMore: String = (trimmedString! as NSString).replacingCharacters(in: NSRange(location: location, length: readMoreLength), with: "") + trailingText
        let answerAttributed = NSMutableAttributedString(string: trimmedForReadMore, attributes: [NSAttributedString.Key.font: self.font])
        let readMoreAttributed = NSMutableAttributedString(string: moreText, attributes: [NSAttributedString.Key.font: moreTextFont, NSAttributedString.Key.foregroundColor: moreTextColor])
        answerAttributed.append(readMoreAttributed)
        self.attributedText = answerAttributed
    }
    
    var vissibleTextLength: Int {
        let font: UIFont = self.font
        let mode: NSLineBreakMode = .byWordWrapping //self.lineBreakMode
        let labelWidth: CGFloat = self.frame.size.width - CGFloat(20)
        let labelHeight: CGFloat = self.frame.size.height
        let sizeConstraint = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
        
        let attributes: [AnyHashable: Any] = [NSAttributedString.Key.font: font]
        let attributedText = NSAttributedString(string: self.text!, attributes: attributes as? [NSAttributedString.Key : Any])
        let boundingRect: CGRect = attributedText.boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, context: nil)
        
        if boundingRect.size.height > labelHeight {
            var index: Int = 0
            var prev: Int = 0
            let characterSet = CharacterSet.whitespacesAndNewlines
            repeat {
                prev = index
                if mode == NSLineBreakMode.byCharWrapping {
                    index += 1
                } else {
                    index = (self.text! as NSString).rangeOfCharacter(from: characterSet, options: [], range: NSRange(location: index + 1, length: self.text!.count - index - 1)).location
                }
            } while index != NSNotFound && index < self.text!.count && (self.text! as NSString).substring(to: index).boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, attributes: attributes as? [NSAttributedString.Key : Any], context: nil).size.height <= labelHeight
            return prev
        }
        return self.text!.count
    }
}

