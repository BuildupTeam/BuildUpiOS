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
    @IBOutlet private weak var seeAllLabel: UILabel!
    @IBOutlet private weak var seeAllButton: UIButton!
    @IBOutlet private weak var containerView: UIView!
    
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
        titleLabel.font = .appFont(ofSize: 17, weight: .bold)
        seeAllLabel.font = .appFont(ofSize: 13, weight: .semiBold)
        
        titleLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        seeAllLabel.textColor = ThemeManager.colorPalette?.lightTextColor?.toUIColor(hexa: ThemeManager.colorPalette?.lightTextColor ?? "")
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
    }
    
    private func bindData() {
        guard let homeSectionModel = homeSectionModel else { return }
        
        if (homeSectionModel.products?.isEmpty ?? false) || homeSectionModel.categories?.isEmpty ?? false {
            containerView.isHidden = true
        } else {
            containerView.isHidden = false
        }
        
        if let component = homeSectionModel.component {
            titleLabel.text = component.title
            
            if (component.allowShowMore ?? false) {
                seeAllButton.isHidden = false
                seeAllLabel.isHidden = false
            } else {
                seeAllButton.isHidden = true
                seeAllLabel.isHidden = true
            }
            
            if component.design == HomeDesign.banner1.rawValue {
                containerView.isHidden = true
            }
        }
    }
    
    @IBAction func seeAllButtonAction(_ sender: UIButton) {
        if let model = homeSectionModel {
            delegate?.seeAllButtonClicked(model)
        }
    }
}
