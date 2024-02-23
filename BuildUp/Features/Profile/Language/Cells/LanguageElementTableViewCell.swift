//
//  LanguageElementTableViewCell.swift
//  flyers
//
//  Created by Mohammed Khaled on 19/02/2023.
//

import UIKit

class LanguageElementTableViewCell: UITableViewCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var selectedPaymentView: UIView!

    var languageModel: LanguageModel? {
        didSet {
            bindData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }

    private func setupCell() {
        titleLabel.font = .appFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        containerView.backgroundColor = .white
        
        selectedPaymentView.layer.masksToBounds = true
        selectedPaymentView.layer.cornerRadius = selectedPaymentView.frame.size.width / 2
        selectedPaymentView.backgroundColor = ThemeManager.colorPalette?.buttonColor2?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor2 ?? "")
    }
    
    private func bindData() {
        titleLabel.text = languageModel?.name

        if languageModel?.isSelected ?? false {
            selectedPaymentView.showView()
        } else {
            selectedPaymentView.hideView()
        }
    }
}
