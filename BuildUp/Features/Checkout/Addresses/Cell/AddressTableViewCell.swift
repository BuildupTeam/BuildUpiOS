//
//  AddressTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 25/11/2023.
//

import UIKit

protocol AddressCellDelegate: AnyObject {
    func editButtonClicked(addressModel: AddressModel)
}

class AddressTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var countryTitleLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var addressTitleLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var editAddressButton: UIButton!
    
    weak var delegate: AddressCellDelegate?
    
    var addressModel: AddressModel? {
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
        nameLabel.font = .appFont(ofSize: 15, weight: .semiBold)
        countryTitleLabel.font = .appFont(ofSize: 13, weight: .regular)
        countryLabel.font = .appFont(ofSize: 13, weight: .medium)
        addressTitleLabel.font = .appFont(ofSize: 13, weight: .regular)
        addressLabel.font = .appFont(ofSize: 13, weight: .medium)
        editAddressButton.titleLabel?.font = .appFont(ofSize: 13, weight: .medium)

        nameLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        countryTitleLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        countryLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        addressTitleLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        addressLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        editAddressButton.setTitleColor(ThemeManager.colorPalette?.buttonColor2?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor2 ?? ""), for: .normal)
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getCardBG().toUIColor(hexa: ThemeManager.colorPalette?.getCardBG() ?? "")
        
        countryTitleLabel.text = L10n.Checkout.country
        addressTitleLabel.text = L10n.Checkout.address
        editAddressButton.setTitle(L10n.Checkout.edit, for: .normal)
        
        containerView.setShadow(
            shadowRadius: CGFloat(5),
            xOffset: 0,
            yOffset: 0,
            color: .black,
            opacity: 0.15,
            cornerRadius: 8,
            masksToBounds: false)
    }
    
    private func bindData() {
        if let model = addressModel {
            nameLabel.text = CachingService.getUser()?.customer?.fullName
            addressLabel.text = model.addressDescription ?? ""
            countryLabel.text = (model.country?.name ?? "") + ", " + (model.city?.name ?? "")
        }
    }
    
    @IBAction func editButtonAction(_ sender: UIButton) {
        if let model = addressModel {
            delegate?.editButtonClicked(addressModel: model)
        }
    }
}
