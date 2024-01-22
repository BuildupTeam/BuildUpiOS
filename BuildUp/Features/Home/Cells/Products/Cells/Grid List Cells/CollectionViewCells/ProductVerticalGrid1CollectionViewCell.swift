//
//  ProductVerticalGrid1CollectionViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 10/06/2023.
//

import UIKit

class ProductVerticalGrid1CollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var addToFavoriteImageView: UIImageView!
    
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var addToFavoriteButton: UIButton!

    @IBOutlet private weak var addToFavoriteView: UIView!
    @IBOutlet private weak var containerView: UIView!
           
    weak var addToFavDelegate: ProductFavoriteDelegate?

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
        productNameLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        
        addToFavoriteView.backgroundColor = ThemeManager.colorPalette?.favouriteBg?.toUIColor(hexa: ThemeManager.colorPalette?.favouriteBg ?? "")
//        addToFavoriteView.layer.masksToBounds = true
//        addToFavoriteView.layer.cornerRadius = addToFavoriteView.frame.size.width / 2
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getCardBG().toUIColor(hexa: ThemeManager.colorPalette?.getCardBG() ?? "")

        ThemeManager.setCornerRadious(element: productImageView, radius: 8)
        ThemeManager.setCornerRadious(element: addToFavoriteView, radius: addToFavoriteView.frame.size.width / 2)
    }
    
    func bindData() {
        if let model = productModel {
            productNameLabel.text = model.name
            
            if let imageUrl = model.mainImage?.path {
                productImageView.setImage(with: imageUrl)
            } else {
                productImageView.image = UIImage() //  Asset.icPlaceholderProduct.image
            }
            
            if model.isFavorite {
                self.addToFavoriteImageView.image = Asset.productFavorite.image
            } else {
                self.addToFavoriteImageView.image = Asset.productUnFavorite.image
            }
        }
        
        ThemeManager.setCornerRadious(element: productImageView, radius: 8)
    }
    
    @IBAction func addToFavoriteAction(_ sender: UIButton) {
        if CachingService.getUser() == nil {
            addToFavDelegate?.pleaseLoginFirst()
            return
        }
        if let model = productModel {
            if model.isFavorite {
                self.addToFavoriteImageView.image = Asset.productUnFavorite.image
            } else {
                self.addToFavoriteImageView.image = Asset.productFavorite.image
            }
            let favoriteModel = FirebaseFavoriteModel(uuid: model.uuid ?? "", isFavorite: model.isFavorite,createdAt: (Date().timeIntervalSince1970 * 1000))
            RealTimeDatabaseService.favoriteUnfavoriteProduct(model: favoriteModel)
        }
    }

}
