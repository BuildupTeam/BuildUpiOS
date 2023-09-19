//
//  CategoryDetailsCoverPhoto2.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 17/09/2023.
//

import UIKit

class CategoryDetailsCoverPhoto2: UIView {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    var categoryModel: CategoryModel? {
        didSet {
            self.bindData()
        }
    }
    
    func initialize() {
        ThemeManager.setCornerRadious(element: containerView, radius: 8)
        ThemeManager.setCornerRadious(element: categoryImageView, radius: 8)
    }
    
    private func bindData() {
        if let model = categoryModel {
            if let imageUrl = model.image?.path {
                categoryImageView.setImage(with: imageUrl)
            } else {
                categoryImageView.image = UIImage() //Asset.icPlaceholderProduct.image
            }
        }
    }
}
