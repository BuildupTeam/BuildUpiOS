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

    var orderModel: OrderModel? {
        didSet {
            bindData()
        }
    }
    
    func setupView() {
        statusLabel.font = .appFont(ofSize: 12, weight: .medium)
        statusLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 16
    }
    
    func bindData() {
        if let model = orderModel {
            statusLabel.text = model.status
            
            switch model.status {
            case OrderStatus.placed.rawValue:
                setupPlacedStatus()
            case OrderStatus.delivered.rawValue:
                setupDeliveredStatus()
            case OrderStatus.arriving.rawValue:
                setupArrivingStatus()
            case OrderStatus.canceled.rawValue:
                setupCancelledStatus()
            default:
                return
            }
        }
    }
    
    func setupArrivingStatus() {
        setupView()
        
        statusLabel.textColor = ThemeManager.colorPalette?.orderStatusDispatchedTitle?.toUIColor(hexa: ThemeManager.colorPalette?.orderStatusDispatchedTitle ?? "")
        containerView.backgroundColor = ThemeManager.colorPalette?.orderStatusDispatchedBackground?.toUIColor(hexa: ThemeManager.colorPalette?.orderStatusDispatchedBackground ?? "").withAlphaComponent(0.2)
    }
    
    func setupDeliveredStatus() {
        setupView()
        
        statusLabel.textColor = ThemeManager.colorPalette?.orderStatusDeliveredTitle?.toUIColor(hexa: ThemeManager.colorPalette?.orderStatusDeliveredTitle ?? "")
        containerView.backgroundColor = ThemeManager.colorPalette?.orderStatusDeliveredBackground?.toUIColor(hexa: ThemeManager.colorPalette?.orderStatusDeliveredBackground ?? "").withAlphaComponent(0.2)
    }
    
    func setupPlacedStatus() {
        setupView()
        
        statusLabel.textColor = ThemeManager.colorPalette?.orderStatusPlacedTitle?.toUIColor(hexa: ThemeManager.colorPalette?.orderStatusPlacedTitle ?? "")
        containerView.backgroundColor = ThemeManager.colorPalette?.orderStatusPlacedBackground?.toUIColor(hexa: ThemeManager.colorPalette?.orderStatusPlacedBackground ?? "").withAlphaComponent(0.2)
    }
    
    func setupCancelledStatus() {
        setupView()
        
        statusLabel.textColor = ThemeManager.colorPalette?.orderStatusCanceledTitle?.toUIColor(hexa: ThemeManager.colorPalette?.orderStatusCanceledTitle ?? "")
        containerView.backgroundColor = ThemeManager.colorPalette?.orderStatusCanceledBackground?.toUIColor(hexa: ThemeManager.colorPalette?.orderStatusCanceledBackground ?? "").withAlphaComponent(0.2)
    }
    
}
