//
//  ProductDetailsVariants3InnerTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 09/09/2023.
//

import UIKit

class ProductDetailsVariants3InnerTableViewCell: UITableViewCell {
    @IBOutlet private weak var variantValueLabel: UILabel!
    @IBOutlet private weak var variantNameLabel: UILabel!
    
    var optionModel: ProductDetailsOptionsModel? {
        didSet {
            self.bindData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }

    private func setupCell() {
        variantValueLabel.font = .appFont(ofSize: 12, weight: .semiBold)
        variantNameLabel.font = .appFont(ofSize: 13, weight: .regular)
        
        variantValueLabel.textColor = ThemeManager.colorPalette?.quantityCounterColor?.toUIColor(hexa: ThemeManager.colorPalette?.quantityCounterColor ?? "")
        variantNameLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
    }
    
    private func bindData() {
        if let model = optionModel {
            variantNameLabel.text = model.option?.name
            variantValueLabel.text = model.optionValues?.first?.name
        }
    }
    
}
