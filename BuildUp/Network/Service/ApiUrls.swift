//
//  ApiUrls.swift
//  flyers
//
//  Created by Mahmoud Nasser on 27/09/2022.
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
