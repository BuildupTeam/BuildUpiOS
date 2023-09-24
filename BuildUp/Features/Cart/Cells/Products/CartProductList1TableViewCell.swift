//
//  CartProductList1TableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 22/09/2023.
//

import UIKit

class CartProductList1TableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var productOldPriceMarkedView: UIView!
    @IBOutlet private weak var removeProductView: UIView!
    @IBOutlet private weak var addToWishListView: UIView!
    @IBOutlet private weak var productQuantityView: UIView!
    
    @IBOutlet private weak var productImageView: UIImageView!
    
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productDescriptionLabel: UILabel!
    @IBOutlet private weak var productOldPriceLabel: UILabel!
    @IBOutlet private weak var productNewPriceLabel: UILabel!
    @IBOutlet private weak var variant1Label: UILabel!
    @IBOutlet private weak var variant2Label: UILabel!
    @IBOutlet private weak var productQuantityLabel: UILabel!
    @IBOutlet private weak var addToWishListLabel: UILabel!
    @IBOutlet private weak var removeProductLabel: UILabel!

    @IBOutlet private weak var addToWishListButton: UIButton!
    @IBOutlet private weak var productQuantityButton: UIButton!
    @IBOutlet private weak var removeProductButton: UIButton!
    @IBOutlet private weak var plusButton: UIButton!
    @IBOutlet private weak var minusButton: UIButton!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
