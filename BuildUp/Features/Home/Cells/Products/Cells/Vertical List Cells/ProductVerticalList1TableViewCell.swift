//
//  ProductVerticalList1TableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 06/06/2023.
//

import UIKit

class ProductVerticalList1TableViewCell: UITableViewCell {
    
    @IBOutlet private weak var productImageView: UIImageView!
    
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productOldPriceLabel: UILabel!
    @IBOutlet private weak var productNewPriceLabel: UILabel!
    @IBOutlet private weak var productCountLabel: UILabel!
    
    @IBOutlet private weak var addToCartButton: UIButton!
    
    @IBOutlet private weak var addToCartView: UIView!
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
        productNameLabel.font = .appFont(ofSize: 13, weight: .bold)
        productOldPriceLabel.font = .appFont(ofSize: 13, weight: .bold)
        productNewPriceLabel.font = .appFont(ofSize: 13, weight: .bold)
        productCountLabel.font = .appFont(ofSize: 15, weight: .semiBold)
        addToCartButton.titleLabel?.font = .appFont(ofSize: 13, weight: .semiBold)

        productOldPriceLabel.textColor = ThemeManager.colorPalette?.priceBefore?.toUIColor(hexa: ThemeManager.colorPalette?.priceBefore ?? "")
        productNewPriceLabel.textColor = ThemeManager.colorPalette?.priceAfter?.toUIColor(hexa: ThemeManager.colorPalette?.priceAfter ?? "")
        productNameLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        productCountLabel.textColor = ThemeManager.colorPalette?.quantityCounterColor?.toUIColor(hexa: ThemeManager.colorPalette?.quantityCounterColor ?? "")
//        addToCartButton.setTitleColor(ThemeManager.colorPalette?.bu?.toUIColor(hexa: ThemeManager.colorPalette?.quantityCounterColor ?? ""), for: <#T##UIControl.State#>)
        addToCartButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        
        ThemeManager.setCornerRadious(element: addToCartButton, radius: 15)
        ThemeManager.setCornerRadious(element: productImageView, radius: 8)
        ThemeManager.setCornerRadious(element: addToCartView, radius: 8)
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
    
    @IBAction func addToCartAction(_ sender: UIButton) {
        addToCartButton.isHidden = true
        addToCartView.isHidden = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
