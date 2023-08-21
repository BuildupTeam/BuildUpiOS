//
//  CachingService.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 20/05/2023.
//

import Foundation
import UIKit
import SwiftKeychainWrapper

extension KeychainWrapper.Key {
    static let userModel: KeychainWrapper.Key = .init(rawValue: Constant.Keys.userModel)
}

class CachingService: NSObject {
    static let shared = CachingService()
    
    static func setSuportedLanguages(languages: [LanguageModel]) {
        let userDefaults = UserDefaults.standard
        do {
            let encodedData: Data = try NSKeyedArchiver.archivedData(
                withRootObject: languages,
                requiringSecureCoding: false)
            userDefaults.set(encodedData, forKey: Constant.Keys.supportedLanguages)
            userDefaults.synchronize()
            
        } catch {
            
        }
    }
    
    static func getSuportedLanguages() -> [LanguageModel]? {
        if UserDefaults.standard.object(forKey: Constant.Keys.supportedLanguages) != nil {
            guard let decoded = UserDefaults.standard.object(forKey: Constant.Keys.supportedLanguages) as? Data else { return nil }
            do {
                if let languages = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(
                    decoded as Data) as? [LanguageModel] {
                    return languages
                }
            } catch {
                
            }
        }
        return nil
    }
    
    static func setHomeData(homeSections: [HomeSectionModel]) {
        let userDefaults = UserDefaults.standard
        do {
            let encodedData: Data = try NSKeyedArchiver.archivedData(
                withRootObject: homeSections,
                requiringSecureCoding: false)
            userDefaults.set(encodedData, forKey: Constant.Keys.homeModel)
            userDefaults.synchronize()
            
        } catch {
            
        }
    }
    
    static func getHomeData() -> [HomeSectionModel]? {
        if UserDefaults.standard.object(forKey: Constant.Keys.homeModel) != nil {
            guard let decoded = UserDefaults.standard.object(forKey: Constant.Keys.homeModel) as? Data else { return nil }
            do {
                if let homeSection = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(
                    decoded as Data) as? [HomeSectionModel] {
                    return homeSection
                }
            } catch {
                
            }
        }
        return nil
    }
    
    static func setThemeData(theme: ThemeConfigurationDataModel) {
        let userDefaults = UserDefaults.standard
        do {
            let encodedData: Data = try NSKeyedArchiver.archivedData(
                withRootObject: theme,
                requiringSecureCoding: false)
            userDefaults.set(encodedData, forKey: Constant.Keys.theme)
            userDefaults.synchronize()
            
        } catch {
            
        }
    }
    
    static func getThemeData() -> ThemeConfigurationDataModel? {
        if UserDefaults.standard.object(forKey: Constant.Keys.theme) != nil {
            guard let decoded = UserDefaults.standard.object(forKey: Constant.Keys.theme) as? Data else { return nil }
            do {
                if let theme = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(
                    decoded as Data) as? ThemeConfigurationDataModel {
                    return theme
                }
            } catch {
                
            }
        }
        return nil
    }
    
    static func clearHomeData() {
        setHomeData(homeSections: [])
    }
    
//    static func setUser(_ userModel: UserModel) {
//        let userDefaults = UserDefaults.standard
//        do {
//            let encodedData: Data = try NSKeyedArchiver.archivedData(
//                withRootObject: userModel,
//                requiringSecureCoding: false)
//            userDefaults.set(encodedData, forKey: Constant.Keys.userModel)
//            userDefaults.synchronize()
//
//        } catch {
//
//        }
//    }
//
//    static func getUser() -> UserModel? {
//        if UserDefaults.standard.object(forKey: Constant.Keys.userModel) != nil {
//            guard let decoded = UserDefaults.standard.object(forKey: Constant.Keys.userModel) as? Data else { return nil }
//            do {
//                if let user = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(
//                    decoded as Data) as? UserModel {
//                    return user
//                }
//            } catch {
//
//            }
//        }
//        return nil
//    }
//
//    static func clearUserData() {
//        UserDefaults.standard.removeObject(forKey: Constant.Keys.userModel)
//    }
    
//    static func updateUser(user: UserInfoModel?) {
//        if let user = user {
//            if let userModel = CachingService.getUser() {
//                userModel.user = user
//                CachingService.setUser(userModel)
//            }
//        }
//    }
    
    static func setUser(_ userModel: UserModel) {
        do {
            let encodedData: Data = try NSKeyedArchiver.archivedData(
                withRootObject: userModel,
                requiringSecureCoding: false)
            KeychainWrapper.standard[.userModel] = encodedData
        } catch {

        }
    }

    static func getUser() -> UserModel? {
        guard let user = KeychainWrapper.standard.object(forKey: Constant.Keys.userModel) as? UserModel else { return nil }
        return user
    }

    static func clearUserData() {
        KeychainWrapper.standard.removeObject(forKey: Constant.Keys.userModel)
    }
    
    static func removeAllCachedData() {
        UserDefaults.standard.removeObject(forKey: Constant.Keys.userModel)
        UserDefaults.standard.removeObject(forKey: Constant.Keys.selectedCategory)
        UserDefaults.standard.removeObject(forKey: Constant.Keys.selectedCountry)
        UserDefaults.standard.removeObject(forKey: Constant.Keys.supportedLanguages)
    }
}
