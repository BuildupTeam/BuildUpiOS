//
//  UpdateProfilePictureResponseModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 06/12/2023.
//

import Foundation
import ObjectMapper

class UpdateProfilePictureResponseModel: BaseResponse {

    var data: FileModel?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
