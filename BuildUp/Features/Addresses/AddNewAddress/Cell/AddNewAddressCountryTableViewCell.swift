//
//  AddNewAddressCountryTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 25/11/2023.
//

import UIKit

class AddNewAddressCountryTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var countryContainerView: UIView!
    @IBOutlet private weak var titleLable: UILabel!
    @IBOutlet private weak var textField: UITextField!
    
    var countryModel: CountryModel? {
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
        textField.isEnabled = false
        
        titleLable.text = L10n.Checkout.country
        titleLable.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        titleLable.font = .appFont(ofSize: 13, weight: .medium)
        
        countryContainerView.layer.cornerRadius = 8
        countryContainerView.layer.masksToBounds = true
        countryContainerView.layer.borderWidth = 1
        countryContainerView.layer.borderColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "").cgColor
        
        textField.backgroundColor = .clear
        textField.setPlaceholder(
            placeholder: "\(L10n.Checkout.countryPlaceholder)",
            font: .appFont(ofSize: 12, weight: .regular))
    }
    
    private func bindData() {
        textField.text = countryModel?.name
    }
}
