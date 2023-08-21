//
//  CategoriesVerticalScrollingCollectionViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 16/06/2023.
//

import UIKit

class CategoriesHorizontalList1CollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var categoryNameLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!
    
    var isCurved: Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }
    
    private func setupCell() {
        categoryNameLabel.font = .appFont(ofSize: 15, weight: .regular)
        
        if isCurved != nil {
            containerView.layer.masksToBounds = true
            containerView.layer.cornerRadius = 8
        }
    }
    
    func bind() {
        categoryNameLabel.text = "Mohammed"

    }

}
