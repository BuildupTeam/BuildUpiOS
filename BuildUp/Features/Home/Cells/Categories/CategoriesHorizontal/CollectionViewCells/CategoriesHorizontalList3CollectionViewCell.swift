//
//  CategoriesHorizontalList3CollectionViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 23/06/2023.
//

import UIKit

class CategoriesHorizontalList3CollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var categoryImageView: UIImageView!
    @IBOutlet private weak var categoryNameLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!
    
    var isCurved: Bool?
    
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
        categoryNameLabel.font = .appFont(ofSize: 13, weight: .semiBold)
        categoryNameLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 4
        
        ThemeManager.setCornerRadious(element: categoryImageView, radius: 8)
    }
    
    func bindData() {
        if let model = categoryModel {
            categoryNameLabel.text = model.name
            if let imageUrl = model.image?.path {
                categoryImageView.setImage(with: imageUrl)
            } else {
                categoryImageView.image = Asset.icPlaceholderProduct.image
            }
        }
    }

}
