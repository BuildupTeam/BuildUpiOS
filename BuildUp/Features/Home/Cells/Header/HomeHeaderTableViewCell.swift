//
//  HomeHeaderTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 22/08/2023.
//

import UIKit

protocol HomeHeaderCellDelegate: AnyObject {
    func seeAllButtonClicked(_ homeSectionModel: HomeSectionModel)
}

class HomeHeaderTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var seeAllButton: UIButton!
    
    
    weak var delegate: HomeHeaderCellDelegate?
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupCell() {
        titleLabel.font = .appFont(ofSize: 16, weight: .bold)
        seeAllButton.titleLabel?.font = .appFont(ofSize: 13, weight: .semiBold)
        
        titleLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        seeAllButton.setTitleColor(ThemeManager.colorPalette?.lightTextColor?.toUIColor(hexa: ThemeManager.colorPalette?.lightTextColor ?? ""), for: .normal)
    }
    
    private func bindData() {
        if let component = homeSectionModel?.component {
            titleLabel.text = component.title
            
            if (component.allowShowMore ?? false) {
                seeAllButton.isHidden = false
            } else {
                seeAllButton.isHidden = true
            }
        }
    }
    
    @IBAction func seeAllButtonAction(_ sender: UIButton) {
        if let model = homeSectionModel {
            delegate?.seeAllButtonClicked(model)
        }
    }
}
