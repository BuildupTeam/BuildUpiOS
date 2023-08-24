//
//  ShimmerProductVerticalListTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 09/08/2023.
//

import UIKit

class ShimmerProductVerticalListTableViewCell: UITableViewCell {

    @IBOutlet private weak var shimmerImageView: UIImageView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }
    
    func setupCell() {
//        shimmerImageView.layer.cornerRadius = 4
    }
    
}
