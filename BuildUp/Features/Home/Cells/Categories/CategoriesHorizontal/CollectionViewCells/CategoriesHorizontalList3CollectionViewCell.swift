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
    @IBOutlet private weak var categoryImageContainerView: UIView!

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
        
//        containerView.setShadow(
//            shadowRadius: CGFloat(5),
//            xOffset: 0,
//            yOffset: 0,
//            color: .black,
//            opacity: 0.15,
//            cornerRadius: 8,
//            masksToBounds: false)
        
        ThemeManager.setCornerRadious(element: categoryImageView, radius: 8)
        ThemeManager.setCornerRadious(element: categoryImageContainerView, radius: 8)
//        ThemeManager.roundCorners(element: categoryImageView, corners: [.topLeft, .topRight], radius: 8)
    }
    
    func bindData() {
        if let model = categoryModel {
            categoryNameLabel.text = model.name
            if let imageUrl = model.image?.path {
                categoryImageView.setImage(with: imageUrl)
            } else {
                categoryImageView.image = UIImage() //Asset.icPlaceholderProduct.image
            }
        }
    }

}
