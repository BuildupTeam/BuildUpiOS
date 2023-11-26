//
//  AddNewAddressCityTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 25/11/2023.
//

import UIKit

class AddNewAddressCityTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var cityContainerView: UIView!
    @IBOutlet private weak var titleLable: UILabel!
    @IBOutlet private weak var textField: UITextField!
    
    var cityModel: CityModel? {
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
        titleLable.text = L10n.Checkout.city
        titleLable.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        titleLable.font = .appFont(ofSize: 13, weight: .medium)
        
        cityContainerView.layer.cornerRadius = 8
        cityContainerView.layer.masksToBounds = true
        cityContainerView.layer.borderWidth = 1
        cityContainerView.layer.borderColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "").cgColor
        
        textField.backgroundColor = .clear
        textField.setPlaceholder(
            placeholder: "\(L10n.Checkout.cityPlaceholder)",
            font: .appFont(ofSize: 12, weight: .regular))
    }
    
    private func bindData() {
        textField.text = cityModel?.name
    }
    
}
