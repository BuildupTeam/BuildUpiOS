//
//  ProductVerticalList3InnerTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 24/08/2023.
//

import UIKit

protocol ProductFavoriteDelegate: AnyObject {
    func productFavorite(model: ProductModel)
    func pleaseLoginFirst()
}

class ProductVerticalList3InnerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productOldPriceLabel: UILabel!
    @IBOutlet private weak var productNewPriceLabel: UILabel!
    
    @IBOutlet private weak var addToFavoriteButton: UIButton!
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var addToFavoriteImage: UIImageView!
    
    @IBOutlet private weak var addToCartView: AddToCartIconView!
    @IBOutlet private weak var addToFavoriteView: UIView!
    @IBOutlet private weak var productOldPriceMarkedView: UIView!
    @IBOutlet private weak var productImageContainerView: UIView!

    weak var delegate: ProductFavoriteDelegate?
    weak var addToCartDelegate: AddToCartDelegate?
    
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
        
        productNameLabel.font = .appFont(ofSize: 13, weight: .bold)
        productOldPriceLabel.font = .appFont(ofSize: 13, weight: .bold)
        productNewPriceLabel.font = .appFont(ofSize: 13, weight: .bold)
        
        productNameLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        productOldPriceLabel.textColor = ThemeManager.colorPalette?.priceBefore?.toUIColor(hexa: ThemeManager.colorPalette?.priceBefore ?? "")
        productNewPriceLabel.textColor = ThemeManager.colorPalette?.priceAfter?.toUIColor(hexa: ThemeManager.colorPalette?.priceAfter ?? "")
        productOldPriceMarkedView.backgroundColor = ThemeManager.colorPalette?.priceBefore?.toUIColor(hexa: ThemeManager.colorPalette?.priceBefore ?? "")
        
        addToFavoriteView.backgroundColor = ThemeManager.colorPalette?.favouriteBg?.toUIColor(hexa: ThemeManager.colorPalette?.favouriteBg ?? "")

//        addToFavoriteView.layer.masksToBounds = true
//        addToFavoriteView.layer.cornerRadius = addToFavoriteView.frame.size.width / 2
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getCardBG().toUIColor(hexa: ThemeManager.colorPalette?.getCardBG() ?? "")

        ThemeManager.setImageViewShadow(element: productImageView,
                               shadowRadius: CGFloat(3),
                               xOffset: 0,
                               yOffset: 0,
                               color: .black,
                               opacity: 0.10,
                               cornerRadius: 8,
                               masksToBounds: false)
        
        ThemeManager.setShadow(element: containerView,
                               shadowRadius: CGFloat(5),
                               xOffset: 0,
                               yOffset: 0,
                               color: .black,
                               opacity: 0.15,
                               cornerRadius: 8,
                               masksToBounds: false)
        
        ThemeManager.setCornerRadious(element: addToFavoriteView, radius: addToFavoriteView.frame.size.width / 2)
        ThemeManager.setCornerRadious(element: productImageView, radius: 8)
        ThemeManager.setCornerRadious(element: addToFavoriteButton, radius: addToFavoriteButton.frame.width / 2)
    }
    
    private func bindData() {
        if let model = productModel {
            if model.hasCombinations ?? false {
                addToCartView.hideView()
//                addToCartView.disableAddToCart()
            } else {
                if model.getMaxQuantity() > 0 {
                    addToCartView.showView()
                    addToCartView.productModel = model
                } else {
                    addToCartView.hideView()
                }
            }
            
            productNameLabel.text = model.name ?? ""
            productOldPriceLabel.text = model.originalPrice?.formatted
            productNewPriceLabel.text = model.formattedPrice?.formatted
            
            if let imageUrl = model.mainImage?.path {
                productImageView.setImage(with: imageUrl)
            } else {
                productImageView.image = UIImage() //  Asset.icPlaceholderProduct.image
            }
            
            if (model.discount ?? 0) > 0 {
                productOldPriceLabel.isHidden = false
                productOldPriceMarkedView.isHidden = false
            } else {
                productOldPriceLabel.isHidden = true
                productOldPriceMarkedView.isHidden = true
            }
            
            if model.isFavorite {
                self.addToFavoriteImage.image = Asset.productFavorite.image
            } else {
                self.addToFavoriteImage.image = Asset.productUnFavorite.image
            }
        }
    }
    
    @IBAction func addToFavoriteAction(_ sender: UIButton) {
        if CachingService.getUser() == nil {
            delegate?.pleaseLoginFirst()
            return
        }
        if let model = productModel {
            if model.isFavorite {
                self.addToFavoriteImage.image = Asset.productUnFavorite.image
            } else {
                self.addToFavoriteImage.image = Asset.productFavorite.image
            }
            delegate?.productFavorite(model: model)
            let favoriteModel = FirebaseFavoriteModel(uuid: model.uuid ?? "", isFavorite: model.isFavorite,createdAt: (Date().timeIntervalSince1970 * 1000))
            RealTimeDatabaseService.favoriteUnfavoriteProduct(model: favoriteModel)
        }
    }
    
}

extension ProductVerticalList3InnerTableViewCell: AddToCartDelegate {
    func productModelUpdated(_ model: ProductModel, _ homeSectionModel: HomeSectionModel?) {
        addToCartDelegate?.productModelUpdated(model, nil)
    }
    
    func userShouldLoginFirst() {
        addToCartDelegate?.userShouldLoginFirst()
    }
}
