//
//  CityTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 24/11/2023.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var cityNameLabel: UILabel!
    
    var cityModel: CityModel? {
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
        cityNameLabel.font = .appFont(ofSize: 14, weight: .medium)
        cityNameLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
    }
    
    private func bindData() {
        cityNameLabel.text = cityModel?.name
    }
}
