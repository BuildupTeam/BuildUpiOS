//
//  ProductDetailsQuantityDropDownTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 04/09/2023.
//

import UIKit

class ProductDetailsQuantityDropDownTableViewCell: UITableViewCell {

    @IBOutlet private weak var quantityTitleLabel: UILabel!
    @IBOutlet private weak var quantityLabel: UILabel!
    @IBOutlet private weak var seperatorView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }
    
    private func setupCell() {
        quantityTitleLabel.font = .appFont(ofSize: 13, weight: .semiBold)
        quantityLabel.font = .appFont(ofSize: 13, weight: .semiBold)
        
        quantityTitleLabel.textColor =  ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        quantityLabel.textColor =  ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        seperatorView.backgroundColor = ThemeManager.colorPalette?.separator?.toUIColor(hexa: ThemeManager.colorPalette?.separator ?? "")
    }
}
