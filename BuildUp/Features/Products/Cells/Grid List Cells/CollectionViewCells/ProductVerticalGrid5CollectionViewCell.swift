//
//  ProductVerticalGrid5CollectionViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 14/06/2023.
//

import UIKit

class ProductVerticalGrid5CollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var productImage: UIImageView!

    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!
    
    var isVertical: Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
