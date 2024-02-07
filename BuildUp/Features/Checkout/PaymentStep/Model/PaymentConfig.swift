//
//  PaymentConfig.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 01/01/2024.
//

import Foundation
import ObjectMapper

class PaymentConfig: Mappable, Codable {
    
    var clientKey: String?
    var profileId: String?
    var serverKey: String?

    func mapping(map: Map) {
        clientKey <- map["client_key"]
        profileId <- map["profile_id"]
        serverKey <- map["server_key"]
    }
    
    required init?(map: Map) {

    }
}
