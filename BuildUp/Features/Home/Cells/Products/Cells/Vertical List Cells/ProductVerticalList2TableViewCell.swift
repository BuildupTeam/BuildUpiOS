//
//  ProductVerticalList2TableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 10/06/2023.
//

import UIKit

class ProductVerticalList2TableViewCell: UITableViewCell {

    @IBOutlet private weak var productImageView: UIImageView!
    
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productOldPriceLabel: UILabel!
    @IBOutlet private weak var productNewPriceLabel: UILabel!
    @IBOutlet private weak var productDiscountLabel: UILabel!
    
    @IBOutlet private weak var productDiscountView: UIView!
    @IBOutlet private weak var containerView: UIView!
    
    var homeSectionModel: HomeSectionModel? {
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
        productNameLabel.font = .appFont(ofSize: 14, weight: .semiBold)
        productOldPriceLabel.font = .appFont(ofSize: 13, weight: .bold)
        productNewPriceLabel.font = .appFont(ofSize: 13, weight: .bold)
        productDiscountLabel.font = .appFont(ofSize: 12, weight: .bold)
        
        productNameLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        productOldPriceLabel.textColor = ThemeManager.colorPalette?.priceBefore?.toUIColor(hexa: ThemeManager.colorPalette?.priceBefore ?? "")
        productNewPriceLabel.textColor = ThemeManager.colorPalette?.priceAfter?.toUIColor(hexa: ThemeManager.colorPalette?.priceAfter ?? "")
        productDiscountLabel.textColor = ThemeManager.colorPalette?.badgeTextColor?.toUIColor(hexa: ThemeManager.colorPalette?.badgeTextColor ?? "")
        
        containerView.setShadow(
            shadowRadius: CGFloat(5),
            xOffset: 0,
            yOffset: 0,
            color: .black,
            opacity: 0.15,
            cornerRadius: 8,
            masksToBounds: false)
        
        ThemeManager.setCornerRadious(element: containerView, radius: 8)
        ThemeManager.setCornerRadious(element: productImageView, radius: 8)
        ThemeManager.setCornerRadious(element: productDiscountView, radius: 8)
    }
    
    private func bindData() {
        if let products = homeSectionModel?.products {
            if let model = products.first {
                productNameLabel.text = model.name ?? ""
                productOldPriceLabel.text = String(model.originalPrice ?? 0) + " SAR"
                productNewPriceLabel.text = String(model.currentPrice ?? 0) + " SAR"
                
                if let imageUrl = model.mainImage?.path {
                    productImageView.setImage(with: imageUrl)
                } else {
                    productImageView.image = Asset.icPlaceholderProduct.image
                }
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
