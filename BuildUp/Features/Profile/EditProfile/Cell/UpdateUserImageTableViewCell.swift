//
//  UpdateUserImageTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 06/12/2023.
//

import UIKit

class UpdateUserImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var userUmageContainerView: UIView!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var editProfileModel: EditProfileModel? {
        didSet {
            bindData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }
    
    private func setupCell() {
        userUmageContainerView.layer.masksToBounds = true
        userUmageContainerView.layer.cornerRadius = userUmageContainerView.frame.size.width / 2
        userUmageContainerView.backgroundColor = ThemeManager.colorPalette?.mainBg1?.toUIColor(hexa: ThemeManager.colorPalette?.mainBg1 ?? "")
        
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 46 //profileImageView.frame.size.width / 2
        
//        ThemeManager.setCornerRadious(element: userUmageContainerView, radius: userUmageContainerView.frame.size.width / 2)
//        ThemeManager.setCornerRadious(element: profileImageView, radius: profileImageView.frame.size.width / 2)
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        
        cameraView.layer.masksToBounds = true
        cameraView.layer.cornerRadius = cameraView.frame.size.width / 2
        cameraView.backgroundColor = ThemeManager.colorPalette?.badgeColor?.toUIColor(hexa: ThemeManager.colorPalette?.badgeColor ?? "")
    }
    
    private func bindData() {
        if let model = editProfileModel {
            if let userImage = model.profileImage {
                self.profileImageView.image = userImage
            } else if let userImage = model.avatar?.path {
                self.profileImageView.setImage(with: userImage)
            } else {
                userUmageContainerView.backgroundColor = .clear
            }
        }
    }
    
}
