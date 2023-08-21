//
//  BannerType1TableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 17/06/2023.
//

import UIKit

class BannerType1TableViewCell: UITableViewCell {

    @IBOutlet private weak var bannerImageView: UIImageView!
    @IBOutlet private weak var containerView: UIView!

    var homeSectionModel: HomeSectionModel? {
        didSet {
            bindData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func bindData() {
        
    }
    
}
