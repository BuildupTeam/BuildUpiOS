//
//  ProfileTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 02/12/2023.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var profileTitleLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }
    
    private func setupCell() {
        containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        separatorView.backgroundColor = ThemeManager.colorPalette?.separator?.toUIColor(hexa: ThemeManager.colorPalette?.separator ?? "")

        profileTitleLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        profileTitleLabel.font = .appFont(ofSize: 13, weight: .semiBold)
    }
    
    func setupEditAccount() {
        profileTitleLabel.text = L10n.Profile.editProfile
        profileImageView.image = Asset.icProfileAccount.image
    }
    
    func setupSavedAddresses() {
        profileTitleLabel.text = L10n.Profile.savedAddresses
        profileImageView.image = Asset.icSavedAddresses.image
    }
    
    func setupWishList() {
        profileTitleLabel.text = L10n.Profile.wishlist
        profileImageView.image = Asset.icProfileHeart.image
    }
    
    func setupSetting() {
        profileTitleLabel.text = L10n.Profile.settings
        profileImageView.image = Asset.icProfileSetting.image
    }
    
    func setupLogout() {
        profileTitleLabel.text = L10n.Profile.logout
        profileImageView.image = Asset.icProfileLogout.image
    }
    
}
