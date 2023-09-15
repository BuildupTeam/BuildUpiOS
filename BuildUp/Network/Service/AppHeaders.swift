//
//  AppHeaders.swift
//  BuildUp
//
//  Created by Mohamed Khaled on 14/09/2023.
//

import Foundation

class AppHeaders {
    
    static var appHeaders: [String: String] {
        var configuraion = Configuration()
        var headers: [String: String] = [:]
        
//        headers["x-api-key"] = configuraion.environment.xApiKey
//        headers["Accept"] = Constant.Keys.contentType
//        headers["Content-Type"] = Constant.Keys.contentType
//        headers["Accept-Language"] = LocalizationManager.currentLanguage().code
//        headers["sec-key"] = Constant.Keys.clientSecret
//
//        if let userModel = CachingService.getUser() {
//            headers["Authorization"] = ("Bearer") + " " + (userModel.apiToken ?? "")
//        }
//
//        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String, let versionInt = version.split(separator: ".").first {
//            headers["platform"] = "ios"
//            headers["name"] = "mahmoud"
//            headers["version"] = String(versionInt)
//        }
        
        return headers
    }
}
