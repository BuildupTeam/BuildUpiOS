//
//  HomeModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 21/07/2023.
//

import Foundation

class HomeModel: NSObject, NSCoding {
    var homeSections: [HomeSectionModel] = []
    
    var isAllDynamicDataValid: Bool {
        
        for section in homeSections {
            if let contentType = section.contentType, let order = section.order {
            let isElementValid = switchAndValidate(contentType: contentType, index: order)
                if !isElementValid {
                    return false
                }
            }
        }
        
        return true
    }

    func switchAndValidate(contentType: String, index: Int) -> Bool {
                
        switch contentType {
        case HomeContentType.products.rawValue:
            return homeSections[index].products != nil
        case HomeContentType.categories.rawValue:
            return homeSections[index].categories != nil
        case HomeContentType.banner.rawValue:
            return true
        default:
            return false
        }
    }
    
    override init() {
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()

    }
    
    @objc
    func encode(with aCoder: NSCoder) {

    }
}

extension HomeModel {
    func editHomeSectionsArrayWIthData(
        contentType: String,
        order: String,
        products: [ProductModel]? = nil,
        categories: [CategoryModel]? = nil) {
            
            guard let index = Int(order) else { return }
            
            switch contentType {
            case HomeContentType.products.rawValue:
                homeSections[index].products = products
            case HomeContentType.categories.rawValue:
                homeSections[index].categories = categories
            case HomeContentType.banner.rawValue:
                print("No Data To edit")
            default:
                print("No Such Component")
            }
        }
}
