//
//  ProductVerticalList1TableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 06/06/2023.
//

import UIKit

class ProductVerticalList1TableViewCell: UITableViewCell {
    
    @IBOutlet private weak var productImage: UIImageView!
    
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productOldPriceLabel: UILabel!
    @IBOutlet private weak var productNewPriceLabel: UILabel!
    @IBOutlet private weak var productCountLabel: UILabel!
    
    @IBOutlet private weak var addToCartButton: UIButton!
    
    @IBOutlet private weak var addToCartView: UIView!
    @IBOutlet private weak var containerView: UIView!
    
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
        productNameLabel.font = .appFont(ofSize: 13, weight: .bold)
        productOldPriceLabel.font = .appFont(ofSize: 13, weight: .bold)
        productNewPriceLabel.font = .appFont(ofSize: 13, weight: .bold)
        productCountLabel.font = .appFont(ofSize: 15, weight: .semiBold)
        
        addToCartButton.titleLabel?.font = .appFont(ofSize: 13, weight: .semiBold)
        
        if let isVertical = isVertical {
            addToCartButton.layer.cornerRadius = 7
        }
    }
    
    private func bindData() {
        
    }
    
    @IBAction func addToCartAction(_ sender: UIButton) {
        addToCartButton.isHidden = true
        addToCartView.isHidden = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
