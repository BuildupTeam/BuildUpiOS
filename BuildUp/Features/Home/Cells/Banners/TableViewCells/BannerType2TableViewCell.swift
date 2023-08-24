//
//  BannerType2TableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 17/06/2023.
//

import UIKit

class BannerType2TableViewCell: UITableViewCell {

    @IBOutlet private weak var bannerImageView: UIImageView!
    @IBOutlet private weak var bannerTitleLabel: UILabel!
    @IBOutlet private weak var bannerContentLabel: UILabel!
    
    @IBOutlet private weak var bannerImageContainerView: UIView!
    @IBOutlet private weak var containerView: UIView!
    
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
        bannerTitleLabel.font = .appFont(ofSize: 13, weight: .semiBold)

        bannerTitleLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        
        containerView.setShadow(
            shadowRadius: CGFloat(5),
            xOffset: 0,
            yOffset: 0,
            color: .black,
            opacity: 0.15,
            cornerRadius: 8,
            masksToBounds: false)
        
        ThemeManager.setCornerRadious(element: bannerImageView, radius: 8)
    }

    private func bindData() {
        if let component = homeSectionModel?.component {
//            bannerTitleLabel.text = component.title
            
            if let imageUrl = component.image?.path {
                bannerImageView.setImage(with: imageUrl, placeholderImage: Asset.bannerType1Placeholder.image)
            }
        }
    }
}
