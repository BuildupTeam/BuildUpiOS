//
//  FileModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 06/12/2023.
//

import Foundation
import ObjectMapper

class FileModel: Mappable {
    
    var id: Int?
    var path: String?
    
    func mapping(map: Map) {
        id <- map["id"]
        path <- map["path"]
    }
    
    required init?(map: Map) {

    }
}
