//
//  ProductVerticalGrid3CollectionViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 10/06/2023.
//

import UIKit

class ProductVerticalGrid3CollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productNewPriceLabel: UILabel!
        
    @IBOutlet private weak var addToCartView: AddToCartIconView!
    @IBOutlet private weak var containerView: UIView!
    
    weak var delegate: AddToCartDelegate?
    
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
        addToCartView.delegate = self
        
        containerView.setShadow(
            shadowRadius: CGFloat(5),
            xOffset: 0,
            yOffset: 0,
            color: .black,
            opacity: 0.15,
            cornerRadius: 8,
            masksToBounds: false)
        
        productNameLabel.font = .appFont(ofSize: 12, weight: .regular)
        productNewPriceLabel.font = .appFont(ofSize: 13, weight: .bold)
        
        productNameLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        productNewPriceLabel.textColor = ThemeManager.colorPalette?.priceAfter?.toUIColor(hexa: ThemeManager.colorPalette?.priceAfter ?? "")
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getCardBG().toUIColor(hexa: ThemeManager.colorPalette?.getCardBG() ?? "")
        ThemeManager.roundCorners(element: productImageView, corners: [.topRight, .topLeft], radius: 8)
        ThemeManager.setCornerRadious(element: containerView, radius: 11)
        ThemeManager.setCornerRadious(element: addToCartView, radius: 8)
    }
    
    func bindData() {
        if let model = productModel {
            if model.hasCombinations ?? false {
                addToCartView.hideView()
            } else {
                if model.getMaxQuantity() > 0 {
                    addToCartView.showView()
                    addToCartView.productModel = model
                } else {
                    addToCartView.hideView()
                }
            }
            
            productNameLabel.text = model.name ?? ""
            productNewPriceLabel.text = model.formattedPrice?.formatted
            
            if let imageUrl = model.mainImage?.path {
                productImageView.setImage(with: imageUrl)
            } else {
                productImageView.image = UIImage() //  Asset.icPlaceholderProduct.image
            }
        }
    }
}

extension ProductVerticalGrid3CollectionViewCell: AddToCartDelegate {
    func productModelUpdated(_ model: ProductModel, _ homeSectionModel: HomeSectionModel?) {
        delegate?.productModelUpdated(model, nil)
    }
    
    func userShouldLoginFirst() {
        delegate?.userShouldLoginFirst()
    }
}

