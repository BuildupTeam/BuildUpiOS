//
//  ProductVerticalList2InnerTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 24/08/2023.
//

import UIKit

class ProductVerticalList2InnerTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var productImageView: UIImageView!
    
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productOldPriceLabel: UILabel!
    @IBOutlet private weak var productNewPriceLabel: UILabel!
    @IBOutlet private weak var productDiscountLabel: UILabel!
    
    @IBOutlet private weak var productDiscountView: UIView!
    @IBOutlet private weak var productOldPriceMarkedView: UIView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var imageHolderContainerView: UIView!

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
    
    private func setupCell() {
        productNameLabel.font = .appFont(ofSize: 13, weight: .bold)
        productOldPriceLabel.font = .appFont(ofSize: 13, weight: .bold)
        productNewPriceLabel.font = .appFont(ofSize: 13, weight: .bold)
        productDiscountLabel.font = .appFont(ofSize: 12, weight: .bold)
        
        productNameLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        productOldPriceLabel.textColor = ThemeManager.colorPalette?.priceBefore?.toUIColor(hexa: ThemeManager.colorPalette?.priceBefore ?? "")
        productNewPriceLabel.textColor = ThemeManager.colorPalette?.priceAfter?.toUIColor(hexa: ThemeManager.colorPalette?.priceAfter ?? "")
        productDiscountLabel.textColor = ThemeManager.colorPalette?.badgeTextColor?.toUIColor(hexa: ThemeManager.colorPalette?.badgeTextColor ?? "")
        productOldPriceMarkedView.backgroundColor = ThemeManager.colorPalette?.priceBefore?.toUIColor(hexa: ThemeManager.colorPalette?.priceBefore ?? "")

//        containerView.setShadow(
//            shadowRadius: CGFloat(5),
//            xOffset: 0,
//            yOffset: 0,
//            color: .black,
//            opacity: 0.15,
//            cornerRadius: 8,
//            masksToBounds: false)
        
        ThemeManager.setShadow(element: containerView,
                               shadowRadius: CGFloat(5),
                               xOffset: 0,
                               yOffset: 0,
                               color: .black,
                               opacity: 0.15,
                               cornerRadius: 8,
                               masksToBounds: false)
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getCardBG().toUIColor(hexa: ThemeManager.colorPalette?.getCardBG() ?? "")

//        ThemeManager.setCornerRadious(element: containerView, radius: 8)
        ThemeManager.setCornerRadious(element: productDiscountView, radius: 8)
        ThemeManager.roundCorners(element: productImageView, corners: [.topLeft, .bottomLeft], radius: 8)
        ThemeManager.roundCorners(element: imageHolderContainerView, corners: [.topLeft, .bottomLeft], radius: 8)
    }
    
    private func bindData() {
        if let model = productModel {
            productNameLabel.text = model.name ?? ""
            productOldPriceLabel.text = String(model.originalPrice ?? 0) + L10n.ProductDetails.currency
            productNewPriceLabel.text = String(model.currentPrice ?? 0) + L10n.ProductDetails.currency
            productDiscountLabel.text = "-" + String(model.discount ?? 0) + " %"
            
            if (model.discount ?? 0) > 0 {
                productDiscountView.isHidden = false
                productOldPriceLabel.isHidden = false
                productOldPriceMarkedView.isHidden = false
            } else {
                productOldPriceLabel.isHidden = true
                productDiscountView.isHidden = true
                productOldPriceMarkedView.isHidden = true
            }
            
            if let imageUrl = model.mainImage?.path {
                productImageView.setImage(with: imageUrl)
            } else {
                productImageView.image = UIImage() //  Asset.icPlaceholderProduct.image
            }
        }
    }
    
}
