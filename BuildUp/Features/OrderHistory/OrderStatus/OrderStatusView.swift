//
//  OrderStatusView.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 29/11/2023.
//

import UIKit

class OrderStatusView: UIView {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var statusLabel: UILabel!

    func setupView() {
        statusLabel.font = .appFont(ofSize: 12, weight: .medium)
        statusLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        
        containerView.backgroundColor = ThemeManager.colorPalette?.mainBg2?.toUIColor(hexa: ThemeManager.colorPalette?.mainBg2 ?? "")
        
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 36
        
    }
}
