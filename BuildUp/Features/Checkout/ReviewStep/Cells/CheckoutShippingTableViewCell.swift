//
//  CheckoutShippingTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 27/11/2023.
//

import UIKit

class CheckoutShippingTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var shippingTitleLabel: UILabel!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var countryTitleLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var addressTitleLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    
    var checkoutModel: CheckoutModel? {
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
        shippingTitleLabel.font = .appFont(ofSize: 15, weight: .semiBold)
        userNameLabel.font = .appFont(ofSize: 15, weight: .semiBold)
        countryTitleLabel.font = .appFont(ofSize: 13, weight: .regular)
        countryLabel.font = .appFont(ofSize: 13, weight: .medium)
        addressTitleLabel.font = .appFont(ofSize: 13, weight: .regular)
        addressLabel.font = .appFont(ofSize: 13, weight: .medium)
        
        shippingTitleLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        userNameLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        countryTitleLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        countryLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        addressTitleLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        addressLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getCardBG().toUIColor(hexa: ThemeManager.colorPalette?.getCardBG() ?? "")
        
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "").cgColor
        
        shippingTitleLabel.text = L10n.Checkout.shippingInfo
        countryTitleLabel.text = L10n.Checkout.country
        addressTitleLabel.text = L10n.Checkout.address
    }
    
    private func bindData() {
        if let model = checkoutModel {
            if let model = model.address {
                userNameLabel.text = CachingService.getUser()?.customer?.fullName
                addressLabel.text = model.addressDescription ?? ""
                countryLabel.text = (model.country?.name ?? "") + ", " + (model.city?.name ?? "")
            }
        }
    }
}
