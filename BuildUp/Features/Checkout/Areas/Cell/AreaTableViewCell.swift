//
//  AreaTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 27/11/2023.
//

import UIKit

class AreaTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var areaNameLabel: UILabel!
    
    var areaModel: AreaModel? {
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
        areaNameLabel.font = .appFont(ofSize: 14, weight: .medium)
        areaNameLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
    }
    
    private func bindData() {
        areaNameLabel.text = areaModel?.name
    }
    
}
