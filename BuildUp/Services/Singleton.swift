//
//  Singltone.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 20/05/2023.
//

import Foundation
import Moya

// MARK: - Singleton

final class Singleton {
    
    // Can't init is singleton
    private init() { }
    
    // MARK: Shared Instance
    
    static let shared = Singleton()
    static var userToken: String?
    static var userEmail: String?
    static var mobileNumber: String?
    static var chatUserId: String?
    
    // MARK: Local Variable
    
    static func setUserToken(token: String?) {
        Singleton.userToken = token
    }
    
    static func getUserToken() -> String? {
        return Singleton.userToken
    }
    
    static func setChatUserId(userId: String?) {
        Singleton.chatUserId = userId
    }
    
    static func getChatUserId() -> String? {
        return Singleton.chatUserId
    }
    
    static func setUserEmail(email: String?) {
        Singleton.userEmail = email
    }
    
    static func getUserEmail() -> String? {
        return Singleton.userEmail
    }
    
    static func setUserMobile(mobile: String?) {
        Singleton.mobileNumber = mobile
    }
    
    static func getUserMobile() -> String? {
        return Singleton.mobileNumber
    }
}
