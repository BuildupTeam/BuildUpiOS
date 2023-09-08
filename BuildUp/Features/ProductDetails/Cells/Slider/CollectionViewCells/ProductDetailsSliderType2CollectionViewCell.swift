//
//  ProductDetailsSliderType2CollectionViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 27/08/2023.
//

import UIKit

class ProductDetailsSliderType2CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var productImageView: UIImageView!

    var productFileModel: ProductFileModel? {
        didSet {
            bindData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func bindData() {
        if let model = productFileModel {
            if let imageUrl = model.path {
                productImageView.setImage(with: imageUrl)
            } else {
                productImageView.image = Asset.icPlaceholderProduct.image
            }
        }
    }

}
