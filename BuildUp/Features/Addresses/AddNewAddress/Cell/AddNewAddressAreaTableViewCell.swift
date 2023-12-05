//
//  AddNewAddressAreaTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 27/11/2023.
//

import UIKit

class AddNewAddressAreaTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var areaContainerView: UIView!
    @IBOutlet private weak var titleLable: UILabel!
    @IBOutlet private weak var textField: UITextField!
    
    var areaModel: AreaModel? {
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
        titleLable.text = L10n.Checkout.area
        titleLable.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        titleLable.font = .appFont(ofSize: 13, weight: .medium)
        
        areaContainerView.layer.cornerRadius = 8
        areaContainerView.layer.masksToBounds = true
        areaContainerView.layer.borderWidth = 1
        areaContainerView.layer.borderColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "").cgColor
        
        textField.backgroundColor = .clear
        textField.setPlaceholder(
            placeholder: "\(L10n.Checkout.areaPlaceholder)",
            font: .appFont(ofSize: 12, weight: .regular))
    }
    
    private func bindData() {
        textField.text = areaModel?.name
    }
    
}
