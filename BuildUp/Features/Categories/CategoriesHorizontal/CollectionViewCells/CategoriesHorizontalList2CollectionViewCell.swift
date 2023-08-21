//
//  CategoriesWithSelectedCollectionViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 16/06/2023.
//

import UIKit

class CategoriesHorizontalList2CollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var categoryImageView: UIImageView!
    @IBOutlet private weak var categoryNameLabel: UILabel!
    @IBOutlet private weak var categoryImageContainerView: UIView!
    @IBOutlet private weak var containerView: UIView!
    
    var isCurved: Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }

    private func setupCell() {
        categoryNameLabel.font = .appFont(ofSize: 13, weight: .semiBold)
        
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 4
        
        if let isCurved = isCurved {
            containerView.layer.masksToBounds = true
            containerView.layer.cornerRadius = 8
        }
    }
    
    func bind() {
        
    }
}
