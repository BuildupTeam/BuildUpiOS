//
//  FirebaseTokenResponseModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 07/11/2023.
//

import Foundation
import ObjectMapper

class FirebaseTokenResponseModel: BaseResponse {
    
    var data: FirebaseDataTokenModel?

    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
