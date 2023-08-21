//
//  ProductVerticalGrid3CollectionViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 10/06/2023.
//

import UIKit

class ProductVerticalGrid3CollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var addToCartImage: UIImageView!

    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productNewPriceLabel: UILabel!
    @IBOutlet private weak var productCountLabel: UILabel!
    
    @IBOutlet private weak var addToCartButton: UIButton!
    
    @IBOutlet private weak var addToCartView: UIView!
    @IBOutlet private weak var addToCartContainerView: UIView!
    @IBOutlet private weak var containerView: UIView!
    
    var isVertical: Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }
    
    private func setupCell() {
        productNameLabel.font = .appFont(ofSize: 13, weight: .regular)
        productNewPriceLabel.font = .appFont(ofSize: 13, weight: .bold)
        productCountLabel.font = .appFont(ofSize: 15, weight: .semiBold)
        
        if let isVertical = isVertical {
            containerView.layer.masksToBounds = true
            containerView.layer.cornerRadius = 8
        }
    }
    
    func bind() {
        
    }
    
    @IBAction func addToCartAction(_ sender: UIButton) {
        addToCartButton.isHidden = true
        addToCartView.isHidden = false
    }

}
