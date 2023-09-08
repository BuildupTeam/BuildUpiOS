//
//  ProductDetailsAttributeType3TableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 31/08/2023.
//

import UIKit

class ProductDetailsVariants3TableViewCell: UITableViewCell {

    @IBOutlet private weak var sizeTitleLabel: UILabel!
    @IBOutlet private weak var variantTitleLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var seperatorView: UIView!

    var optionModel: ProductDetailsOptionsModel? {
        didSet {
            self.bindData()
        }
    }
    
    var productModel: ProductModel? {
        didSet {
            bindData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupCell() {
        sizeTitleLabel.font = .appFont(ofSize: 13, weight: .semiBold)
        variantTitleLabel.font = .appFont(ofSize: 12, weight: .semiBold)
        
        seperatorView.backgroundColor = ThemeManager.colorPalette?.separator?.toUIColor(hexa: ThemeManager.colorPalette?.separator ?? "")
        sizeTitleLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        variantTitleLabel.textColor = ThemeManager.colorPalette?.quantityCounterColor?.toUIColor(hexa: ThemeManager.colorPalette?.quantityCounterColor ?? "")
    }
    
    private func bindData() {
        titleLabel.text = optionModel?.option?.name
//        variantTitleLabel.text = optionModel?.option
    }
}
