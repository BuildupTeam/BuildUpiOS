//
//  ProductDetailsSliderType1CollectionViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 27/08/2023.
//

import UIKit

class ProductDetailsSliderType1CollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var productImageView: UIImageView!

    var productFileModel: ProductFileModel? {
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
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = containerView.frame.width / 2
    }
    
    private func bindData() {
        if let model = productFileModel {
            if model.isSelected {
                containerView.layer.borderWidth = 1
                containerView.layer.borderColor = ThemeManager.colorPalette?.buttonBorderIconColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderIconColor ?? "").cgColor
            } else {
                containerView.layer.borderWidth = 0
                containerView.layer.borderColor = UIColor.clear.cgColor
            }
            
            if let imageUrl = model.path {
                productImageView.setImage(with: imageUrl)
            } else {
                productImageView.image = UIImage() //  Asset.icPlaceholderProduct.image
            }
        }
    }

}
