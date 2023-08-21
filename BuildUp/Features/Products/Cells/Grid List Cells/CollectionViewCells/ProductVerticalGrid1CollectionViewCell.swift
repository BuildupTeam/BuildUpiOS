//
//  ProductVerticalGrid1CollectionViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 10/06/2023.
//

import UIKit

class ProductVerticalGrid1CollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var addToFavoriteImage: UIImageView!
    
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var addToFavoriteButton: UIButton!

    @IBOutlet private weak var addToFavoriteView: UIView!
    @IBOutlet private weak var containerView: UIView!
    
    var isVertical: Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }
    
    private func setupCell() {
        productNameLabel.font = .appFont(ofSize: 14, weight: .bold)
        
        if let isVertical = isVertical {
            productImage.layer.masksToBounds = true
            productImage.layer.cornerRadius = 8
        }
    }
    
    func bind() {
        
    }
    
    @IBAction func addToFavoriteAction(_ sender: UIButton) {
        
    }

}
