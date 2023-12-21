//
//  EditProfileModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 06/12/2023.
//

import Foundation
import CountryPickerView
import UIKit

class EditProfileModel: NSObject {
    var fullName: String?
    var email: String?
    var phone: String?
    var countryCode: String?
    var countryFlag: UIImage?
    var avatarId: Int?
    var avatar: MainImageModel?
    var avatarData: Data?
    var profileImage: UIImage?
    
    override init() {
        
    }
    
    var countryImage: UIImage? {
        let countryPickerView = CountryPickerView()
        return countryPickerView.getCountryByPhoneCode(countryCode ?? "")?.flag
    }
    
    var countryCodeWithoutPlus: String {
        return countryCode?.replacingOccurrences(of: "+", with: "") ?? ""
    }
    
    func isFieldsEmpty() -> Bool {
        if !(fullName?.isEmpty ?? false) && !(email?.isEmpty ?? false) && !(phone?.isEmpty ?? false) {
            return false
        }
        return true
    }
}
