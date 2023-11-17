//
//  ProductCombinationsOptionTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 13/11/2023.
//

import UIKit

class ProductCombinationsOptionTableViewCell: UITableViewCell {
    @IBOutlet private weak var optionTitleLabel: UILabel!

    var cartOptionModel: CartCombinationsOptionModel? {
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
        optionTitleLabel.font = .appFont(ofSize: 13, weight: .semiBold)
        optionTitleLabel.textColor = ThemeManager.colorPalette?.subtitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.subtitleColor ?? "")
    }
    
    private func bindData() {
        if let model = cartOptionModel {
            optionTitleLabel.text = (model.option?.name ?? "") + ": " + (model.optionValue?.name ?? "")
        }
    }
    
}
