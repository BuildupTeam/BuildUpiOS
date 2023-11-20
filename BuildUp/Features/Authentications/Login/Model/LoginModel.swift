//
//  LoginModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 30/10/2023.
//

import Foundation
import UIKit

class LoginModel {
    var phone: String?
    var countryCode: String?
    var password: String?
    var isValidMobileNumber = false
    var isValidPasssword = false
    var countryFlag: UIImage?
    
    var countryCodeWithoutPlus: String {
        return countryCode?.replacingOccurrences(of: "+", with: "") ?? ""
    }

    init() {
        
    }
}
