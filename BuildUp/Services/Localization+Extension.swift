//
//  Localization+Extension.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 20/05/2023.
//

import UIKit

extension Bundle {

    @objc
    func appLocalizedString(forKey key: String, value: String?, table tableName: String?) -> String {

        let currentLangouge = LocalizationManager.currentLanguage()
        var bundle = Bundle.main
        if let path = Bundle.main.path(forResource: currentLangouge.appLanguageCode, ofType: "lproj"),
            let appBundle = Bundle(path: path) {
            bundle = appBundle
        }
        return bundle.appLocalizedString(forKey: key, value: value, table: tableName)
    }
}

extension UIApplication {

    @objc var appUserInterfaceLayoutDirection: UIUserInterfaceLayoutDirection {
        var direction: UIUserInterfaceLayoutDirection = .leftToRight
        if LocalizationManager.currentLanguage().appLanguageCode == Language.arabic.rawValue {
            direction = .rightToLeft
        }
        return  direction
    }
}

extension UICollectionViewFlowLayout {
    open override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        if LocalizationManager.currentLanguage().appLanguageCode == Language.arabic.rawValue {
            return true
        }
        return false
    }
}
