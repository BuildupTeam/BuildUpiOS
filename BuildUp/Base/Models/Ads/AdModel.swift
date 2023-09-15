//
//  AdModel.swift
//  BuildUp
//
//  Created by Mohamed Khaled on 14/09/2023.
//

import Foundation
import ObjectMapper

class AdModel: Mappable {
    
    var id: Int?
    var message: String?
    var goal: GoalModel?
    var type: AdTypeModel?
    var endAt: String?
    var image: String?
    var budget: Float?
    var spend: Float?
    var startAt: String?
    var status: AdTypeModel?
    var isActive: Bool?
    var adminStatus: String?
    var facebookStatus: String?
    var referenceNo: String?
    var url: String?
    var days: Int?

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        message <- map["message"]
        goal <- map["goal"]
        type <- map["type"]
        endAt <- map["endAt"]
        image <- map["image"]
        image <- map["photo"]
        budget <- map["budget"]
        spend <- map["spend"]
        startAt <- map["start_at"]
        status <- map["status"]
        isActive <- map["isActive"]
        adminStatus <- map["adminStatus"]
        facebookStatus <- map["facebookStatus"]
        referenceNo <- map["referenceNo"]
        url <- map["url"]
        days <- map["days"]
    }
}
