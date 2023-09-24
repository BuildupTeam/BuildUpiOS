//
//  CategoriesVerticalGrid9CollectionViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 16/06/2023.
//

import UIKit

class CategoriesVerticalGrid3CollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var categoryImageView: UIImageView!
    @IBOutlet private weak var containerView: UIView!
    
    var categoryModel: CategoryModel? {
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
        ThemeManager.setShadow(element: containerView,
                               shadowRadius: CGFloat(5),
                               xOffset: 0,
                               yOffset: 0,
                               color: .black,
                               opacity: 0.15,
                               cornerRadius: 8,
                               masksToBounds: false)
        
        ThemeManager.setCornerRadious(element: categoryImageView, radius: 8)
    }
    
    func bindData() {
        if let model = categoryModel {
            if let imageUrl = model.image?.path {
                categoryImageView.setImage(with: imageUrl)
            } else {
                categoryImageView.image = UIImage() //Asset.icPlaceholderProduct.image
            }
        }
    }
}
