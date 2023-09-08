//
//  ProductFileModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 26/08/2023.
//

import Foundation
import ObjectMapper

class ProductFileModel: Mappable {
    var id: Int?
    var path: String?
    var originalName: String?
    var mimeType: String?
    var folderName: String?
    var createdAt: String?
    var isSelected = false
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        path <- map["path"]
        originalName <- map["original_name"]
        mimeType <- map["mime_type"]
        folderName <- map["folder_name"]
        createdAt <- map["created_at"]
    }
}
