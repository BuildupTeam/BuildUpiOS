//
//  CheckoutModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 25/11/2023.
//

import Foundation
import UIKit

class CheckoutModel {
    var name: String?
    var phone: String?
    var countryCode: String?
    var address: AddressModel?
    var countryFlag: UIImage?

    var countryCodeWithoutPlus: String {
        return countryCode?.replacingOccurrences(of: "+", with: "") ?? ""
    }
    
    init() {
        
    }
}
