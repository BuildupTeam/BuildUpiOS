//
//  ProductDetailsSizeChartTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 01/09/2023.
//

import UIKit

class ProductDetailsSizeChartTableViewCell: UITableViewCell {

    @IBOutlet private weak var sizeChartTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupCell() {
        sizeChartTitleLabel.font = .appFont(ofSize: 13, weight: .semiBold)
        sizeChartTitleLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
    }
    
}
