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
        
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 16
    }
    
    func setupPendingStatus() {
        setupView()
        
        statusLabel.textColor = ThemeManager.colorPalette?.buttonTextColor4?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor4 ?? "")
        containerView.backgroundColor = ThemeManager.colorPalette?.buttonTextColor4?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor4 ?? "").withAlphaComponent(0.2)
    }
    
    func setupArrivingStatus() {
        setupView()
        
        statusLabel.textColor = ThemeManager.colorPalette?.priceAfter?.toUIColor(hexa: ThemeManager.colorPalette?.priceAfter ?? "")
        containerView.backgroundColor = ThemeManager.colorPalette?.priceAfter?.toUIColor(hexa: ThemeManager.colorPalette?.priceAfter ?? "").withAlphaComponent(0.2)
    }
    
    func setupDeliveredStatus() {
        setupView()
        
        statusLabel.textColor = ThemeManager.colorPalette?.buttonBorderTextColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderTextColor ?? "")
        containerView.backgroundColor = ThemeManager.colorPalette?.buttonBorderTextColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderTextColor ?? "").withAlphaComponent(0.2)
    }
    
}
