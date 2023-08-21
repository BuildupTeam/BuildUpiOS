//
//  Formatters.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 20/05/2023.
//

import Foundation

internal class Formatters {
    
    lazy var formatter = Formatters()

    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.locale = Locale(identifier: "ar")
        return formatter
    }()
    
    private lazy var languageFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.locale = Locale(identifier: "ar")
        return formatter
    }()
    
    /// return localized number in arabic for Quran pages
    func localizeNumber(toArabic page: Int) -> String {
        let number = NSNumber(value: page)
        return numberFormatter.string(from: number) ?? ""
    }
    
    /// return localized number in arabic for Quran pages
    func localize(number: Int) -> String {
        let value = NSNumber(value: number)
        return languageFormatter.string(from: value) ?? ""
    }
}
