//
//  ProductsHeaderTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 16/06/2023.
//

import UIKit

class ProductsHeaderTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var seeAllButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }

    private func setupCell() {
        titleLabel.font = .appFont(ofSize: 17, weight: .bold)
        titleLabel.textColor = .titlesBlack
    }
    
}
