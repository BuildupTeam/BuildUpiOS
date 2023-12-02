//
//  ProfileHeaderTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 02/12/2023.
//

import UIKit
import CountryPickerView

class ProfileHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var userUmageContainerView: UIView!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var countryCodeFlag: UIImageView!
    
    var countryPickerView = CountryPickerView()
    var userModel: CustomerModel? {
        didSet {
            bindData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    private func setupCell() {
        containerView.setShadow(
            shadowRadius: CGFloat(11),
            xOffset: 0,
            yOffset: 0,
            color: .black,
            opacity: 0.15,
            cornerRadius: 8,
            masksToBounds: false)
                
        parentView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        cameraView.layer.masksToBounds = true
        cameraView.layer.cornerRadius = cameraView.frame.size.width / 2
        cameraView.backgroundColor = ThemeManager.colorPalette?.badgeColor?.toUIColor(hexa: ThemeManager.colorPalette?.badgeColor ?? "")
        
        
        ThemeManager.setCornerRadious(element: userUmageContainerView, radius: userUmageContainerView.frame.size.width / 2)
        
        userNameLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        userNameLabel.font = .appFont(ofSize: 16, weight: .bold)
        
        emailLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        emailLabel.font = .appFont(ofSize: 14, weight: .medium)
        
        phoneLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        phoneLabel.font = .appFont(ofSize: 15, weight: .medium)
    }
    
    private func bindData() {
        if let user = self.userModel {
            let phone = user.phone ?? ""
            let phoneCode = "+\(user.countryCode ?? "")"
            let countryFlag = countryPickerView.getCountryByPhoneCode(phoneCode)?.flag
            
            userNameLabel.text = user.fullName
            emailLabel.text = user.email
            phoneLabel.text = phoneCode + phone
            
            countryCodeFlag.image = countryFlag
        }
    }
}
