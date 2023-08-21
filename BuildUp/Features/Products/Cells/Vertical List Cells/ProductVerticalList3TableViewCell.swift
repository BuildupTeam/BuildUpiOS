//
//  ProductVerticalList3TableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 10/06/2023.
//

import UIKit

class ProductVerticalList3TableViewCell: UITableViewCell {

    @IBOutlet private weak var productImage: UIImageView!
    
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productOldPriceLabel: UILabel!
    @IBOutlet private weak var productNewPriceLabel: UILabel!
    @IBOutlet private weak var productCountLabel: UILabel!
    
    @IBOutlet private weak var addToCartButton: UIButton!
    @IBOutlet private weak var addToFavoriteButton: UIButton!
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var addToCartView: UIView!
    @IBOutlet private weak var addToFavoriteView: UIView!
    
    var isVertical: Bool?
    
    var homeSectionModel: HomeSectionModel? {
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
        productNameLabel.font = .appFont(ofSize: 15, weight: .semiBold)
        productOldPriceLabel.font = .appFont(ofSize: 13, weight: .bold)
        productNewPriceLabel.font = .appFont(ofSize: 13, weight: .bold)
        productCountLabel.font = .appFont(ofSize: 15, weight: .semiBold)
        
        
        if let isVertical = isVertical {
            
        }
    }
    
    private func bindData() {
        
    }
    
    @IBAction func addToCartAction(_ sender: UIButton) {
        addToCartButton.isHidden = true
        addToCartView.isHidden = false
    }
    
    @IBAction func addToFavoriteAction(_ sender: UIButton) {
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
