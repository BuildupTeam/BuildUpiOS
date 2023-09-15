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
        static let configurationUrl = "/api/v1/ec/f/settings"
        static let loginUrl = "/api/login"
        static let homeProducts = "/api/v1/ec/f/products"
        static let homeCategories = "/api/v1/ec/f/categories"
        static let productDetails = "/api/v1/ec/f/products/{id}"
        static let relatedProducts = "/api/v1/ec/f/products"
    }
}
