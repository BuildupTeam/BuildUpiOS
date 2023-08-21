//
//  ProductHorizontalList1CollectionViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 14/06/2023.
//

import UIKit

class ProductHorizontalList1CollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var addToFavoriteImage: UIImageView!
    
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productOldPriceLabel: UILabel!
    @IBOutlet private weak var productNewPriceLabel: UILabel!
    
    @IBOutlet private weak var addToFavoriteButton: UIButton!
    
    @IBOutlet private weak var addToFavoriteView: UIView!
    @IBOutlet private weak var containerView: UIView!
    
    var isVertical: Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
