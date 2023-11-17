//
//  ApiUrls.swift
//  BuildUp
//
//  Created by Mohamed Khaled on 14/09/2023.
//

import Foundation

struct ApiUrls {
    
    struct Apis {

        // MARK: - Apis
        static let configurationUrl = "/settings"
        static let registerUrl = "/register"
        static let loginUrl = "/login"
        static let logoutUrl = "/logout"
        
        static let refreshTokenUrl = "/refresh-token"
        static let forgetPasswordUrl = "/forget-password"
        static let resetPasswordUrl = "/reset-password"
        static let homeProducts = "/products"
        static let homeCategories = "/categories"
        static let productDetails = "/products/{id}"
        static let relatedProducts = "/products"
        static let cartUrl = "/cart"
        
        static let fetchFirebaseToken = "/fcm-token"
    }
}
