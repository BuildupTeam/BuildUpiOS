//
//  ProductVerticalList2TableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 10/06/2023.
//

import UIKit

class ProductVerticalList2TableViewCell: UITableViewCell {

    @IBOutlet private weak var productImage: UIImageView!
    
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productOldPriceLabel: UILabel!
    @IBOutlet private weak var productNewPriceLabel: UILabel!
    @IBOutlet private weak var productDiscountLabel: UILabel!
    
    @IBOutlet private weak var productDiscountView: UIView!
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
        productNameLabel.font = .appFont(ofSize: 14, weight: .semiBold)
        productOldPriceLabel.font = .appFont(ofSize: 13, weight: .bold)
        productNewPriceLabel.font = .appFont(ofSize: 13, weight: .bold)
        productDiscountLabel.font = .appFont(ofSize: 12, weight: .bold)
        
        productDiscountView.layer.masksToBounds = true
        productDiscountView.layer.cornerRadius = 4
        
        if let isVertical = isVertical {
            
        }
    }
    
    private func bindData() {
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
