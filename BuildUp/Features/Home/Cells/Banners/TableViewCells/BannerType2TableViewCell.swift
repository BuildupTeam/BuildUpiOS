//
//  BannerType2TableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 17/06/2023.
//

import UIKit

class BannerType2TableViewCell: UITableViewCell {

    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var bannerImageView: UIImageView!
    @IBOutlet private weak var bannerTitleLabel: UILabel!
    
    @IBOutlet private weak var bannerImageContainerView: UIView!
    @IBOutlet private weak var bannerTitleView: UIView!
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
        bannerTitleLabel.font = .appFont(ofSize: 20, weight: .extraBold)

        bannerTitleLabel.textColor = ThemeManager.colorPalette?.sectionTitleColor?.toUIColor(hexa: ThemeManager.colorPalette?.sectionTitleColor ?? "")
        
        ThemeManager.setCornerRadious(element: backgroundImageView, radius: 8)
        ThemeManager.setCornerRadious(element: containerView, radius: 8)
        ThemeManager.roundCorners(element: bannerImageContainerView, corners: [.topRight, .bottomRight], radius: 8)
        ThemeManager.roundCorners(element: bannerImageView, corners: [.topRight, .bottomRight], radius: 8)
//        ThemeManager.roundCorners(element: bannerTitleView, corners: [.topLeft, .bottomLeft], radius: 8)
        
//        ThemeManager.setShadow(element: containerView,
//                               shadowRadius: CGFloat(5),
//                               xOffset: 0,
//                               yOffset: 0,
//                               color: .black,
//                               opacity: 0.15,
//                               cornerRadius: 8,
//                               masksToBounds: false)
        
//        containerView.layer.masksToBounds = true
//        containerView.layer.cornerRadius = 8
        
//        bannerImageContainerView.layer.masksToBounds = true
//        bannerImageContainerView.layer.cornerRadius = 8
    }

    private func bindData() {
        if let component = homeSectionModel?.component {
            bannerTitleLabel.text = component.title
            
            if let imageUrl = component.image?.path {
                bannerImageView.setImage(with: imageUrl, placeholderImage: Asset.bannerType1Placeholder.image)
            }
            if let imageUrl = component.backgroundImage?.path {
                backgroundImageView.setImage(with: imageUrl, placeholderImage: Asset.bannerType1Placeholder.image)
                bannerTitleView.backgroundColor = .clear
            } else {
                if let color = component.backgroundColor {
                    let backgroundColor = color.toUIColor(hexa: color)
                    bannerTitleView.backgroundColor = backgroundColor
                }
            }
        }
    }
}
