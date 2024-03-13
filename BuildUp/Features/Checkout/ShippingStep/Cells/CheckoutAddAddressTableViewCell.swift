//
//  CheckoutAddAddressTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 26/11/2023.
//

import UIKit

class CheckoutAddAddressTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var plusImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }
    
    private func setupCell() {
        titleLabel.font = .appFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = ThemeManager.colorPalette?.buttonBorderTextColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderTextColor ?? "")
        
        titleLabel.text = L10n.Checkout.addNewAddress

        containerView.backgroundColor = ThemeManager.colorPalette?.getCardBG().toUIColor(hexa: ThemeManager.colorPalette?.getCardBG() ?? "")
        
        containerView.layer.borderColor = ThemeManager.colorPalette?.buttonBorderTextColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderTextColor ?? "").cgColor
        containerView.layer.borderWidth = 1
        
        plusImageView.image = Asset.icPlusCircle.image.withRenderingMode(.alwaysTemplate)
        plusImageView.tintColor = ThemeManager.colorPalette?.buttonBorderIconColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderIconColor ?? "")
        
        ThemeManager.setCornerRadious(element: containerView, radius: 8)
    }
    
}
