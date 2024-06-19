//
//  LocalizationManager.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 20/05/2023.
//

import Foundation
import UIKit

class LocalizationManager {
    
    static var defaultLanguage: LanguageModel {
        let languageModel = LanguageModel(
            name: Language.english.languageName,
            code: Language.english.rawValue)

        return languageModel
    }
    
    static var selectedLanguage: LanguageModel {
        return supportedLanguages.first(where: { $0.isSelected == true }) ?? defaultLanguage
    }
    
    static var supportedLanguages: [LanguageModel] = []
    
    struct UserDefaultKey {
        private init () {}
        static let savedLanguage = "AppLanguages"
        static let appleLanguage = "AppleLanguages"
    }

    private init() {  }

    /// This function will sync apple language with default language ,
    /// should called if firstLaunch also it will not effect if called after that.
    /// 
   
    open class func initSupportedLanguages() {
        
        if let cachedSupportedLanguages = CachingService.getSuportedLanguages() {
            supportedLanguages = cachedSupportedLanguages
        } else {
            let arabicLanguage = LanguageModel(name: Language.arabic.languageName, code: Language.arabic.rawValue)
            arabicLanguage.isSelected = false
            
            let englishLanguage = LanguageModel(name: Language.english.languageName, code: Language.english.rawValue)
            englishLanguage.isSelected = true
            
            supportedLanguages = [arabicLanguage, englishLanguage]
        }
    }
    
    open class func unSelectAllSupportedLanguages() {
        for language in supportedLanguages {
            language.isSelected = false
        }
    }
    
    open class func syncLanguage() {
        setAppLangouge(language: LocalizationManager.selectedLanguage)
    }

    open class func swizzleLanguage() {
        swizzleMethodsForClass(className: Bundle.self,
                               originalSelector: #selector(Bundle.localizedString(forKey:value:table:)),
                               overrideSelector: #selector(Bundle.appLocalizedString(forKey:value:table:)))

        swizzleMethodsForClass(className: UIApplication.self,
                               originalSelector: #selector(getter: UIApplication.userInterfaceLayoutDirection),
                               overrideSelector: #selector(getter: UIApplication.appUserInterfaceLayoutDirection))
    }
    
    open class func availableLanguages() -> [String] {
        var availableLanguages = Bundle.main.localizations
        // If excludeBase = true, don't include "Base" in available languages
        if let indexOfBase = availableLanguages.firstIndex(of: "Base") {
            availableLanguages.remove(at: indexOfBase)
        }
        return availableLanguages
    }

    class func currentLanguage() -> LanguageModel {
        return LocalizationManager.selectedLanguage
    }
    
    class func isRTLdirection() -> Bool {

    let currentLanguage = currentLanguage()
        if currentLanguage.appLanguageCode == Language.arabic.rawValue {
            return true
        } else {
            return false
        }
    }
    
    class func shouldMirror(newLanguageCode: String, oldLanguageCode: String) -> Bool {

        if isRTLDirection(backendLanguageCode: newLanguageCode) == isRTLDirection(backendLanguageCode: oldLanguageCode) {
            return false
        } else {
            return true
        }
    }
    
    class func isRTLDirection(backendLanguageCode: String) -> Bool {

        if backendLanguageCode == Language.arabic.rawValue {
            return true
        } else {
            return false
        }
    }
    
    class func getappLanguageCode(from backendLanguageCode: String?) -> String {
       
        if backendLanguageCode == "pt" {
            return "pt-PT"
        } else {
            switch backendLanguageCode {
            case Language.arabic.rawValue:
                return Language.arabic.rawValue
            case Language.english.rawValue:
                return Language.english.rawValue
            default:
                return Language.arabic.rawValue
            }
        }
    }
    
    class func getIosLanguageCode(from backendLanguageCode: String?) -> String {
       
        if backendLanguageCode == "pt" {
            return "pt-PT"
        } else {
            return backendLanguageCode ?? Language.arabic.rawValue
        }
    }
    
    class func getAppLanguage(from appLanguageCode: String) -> Language {
        
        switch appLanguageCode {
        case Language.arabic.rawValue:
            return .arabic
        case Language.english.rawValue:
            return .english
        default:
            return .arabic
        }
    }

    public class func changeLanguage(language: LanguageModel ,
                                     splash: UIViewController? = nil,
                                     splashDuration: TimeInterval = 0.2,
                                     options: UIView.AnimationOptions = [.transitionCrossDissolve],
                                     animationDuration: TimeInterval = 0.5,
                                     resetBlock:@escaping (() -> UIViewController)) {
        guard let appWindow = AppManager.shared.window else { return }

        if let splashScene = splash {
            appWindow.rootViewController = splashScene
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + splashDuration) {

            self.setAppLangouge(language: language)

            let rootView = resetBlock()
            rootView.view.layoutIfNeeded()
          appWindow.rootViewController = rootView
        }

    }

    private class func setAppLangouge(language: LanguageModel) {
        
        unSelectAllSupportedLanguages()
        
        for languageModel in supportedLanguages where language.code == languageModel.code {
            languageModel.isSelected = true
        }
        
        language.isSelected = true
        CachingService.setSuportedLanguages(languages: supportedLanguages)
        updateAppAppearanceAlignmentToSelectedLanguage()
//        UIView.appearance().semanticContentAttribute = language.semantic
//
//        UILabel.appearance().textAlignment
//        = (language.semantic == UISemanticContentAttribute.forceLeftToRight)
//            ? NSTextAlignment.left : NSTextAlignment.right
//
//        UITextField.appearance().textAlignment
//        = (language.semantic == UISemanticContentAttribute.forceLeftToRight)
//            ? NSTextAlignment.left : NSTextAlignment.right
        
        // uiview.appearance().semanticContentAttribute = langauge.semantic
    }

    private class func swizzleMethodsForClass(className: AnyClass,
                                              originalSelector: Selector,
                                              overrideSelector: Selector) {

        // swiftlint:disable force_unwrapping
        let originalMethod: Method = class_getInstanceMethod(className, originalSelector)!
        let overrideMethod: Method = class_getInstanceMethod(className, overrideSelector)!

        if class_addMethod(className,
                           originalSelector,
                           method_getImplementation(overrideMethod),
                           method_getTypeEncoding(overrideMethod)) {

            class_replaceMethod(className,
                                overrideSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod))
        } else {
            // if method exist replace implementation
            method_exchangeImplementations(originalMethod, overrideMethod)
        }
    }
    
    class func updateAppAppearanceAlignmentToSelectedLanguage() {
        UIView.appearance().semanticContentAttribute = LocalizationManager.selectedLanguage.semantic
        
        UILabel.appearance().textAlignment
        = (LocalizationManager.selectedLanguage.semantic == UISemanticContentAttribute.forceLeftToRight)
            ? NSTextAlignment.left : NSTextAlignment.right

        UITextField.appearance().textAlignment
        = (LocalizationManager.selectedLanguage.semantic == UISemanticContentAttribute.forceLeftToRight)
            ? NSTextAlignment.left : NSTextAlignment.right
    }
    
    class func updateAppAppearanceAlignmentToLeft() {
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        UILabel.appearance().textAlignment = .left
        UITextField.appearance().textAlignment = .left
    }
}
