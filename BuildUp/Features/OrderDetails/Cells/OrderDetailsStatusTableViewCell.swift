//
//  OrderDetailsStatusTableViewCell.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 04/12/2023.
//

import UIKit

enum OrderStatus: String {
    case placed = "completed"
    case arriving = "arriving"
    case delivered = "delivered"
    case canceled = "canceled"
    case refunded = "refunded"
    case pendingPayment = "pending_payment"
}

class OrderDetailsStatusTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var orderStatusLabel: UILabel!
    @IBOutlet private weak var orderStatusImageView: UIImageView!
    @IBOutlet private weak var step1View: UIView!
    @IBOutlet private weak var step2View: UIView!
    @IBOutlet private weak var step3View: UIView!

    var orderModel: OrderModel? {
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
        orderStatusLabel.textAlignment = .center
        orderStatusLabel.font = .appFont(ofSize: 15, weight: .semiBold)
        orderStatusLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        
        step1View.backgroundColor = ThemeManager.colorPalette?.buttonBorderIconColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderIconColor ?? "")
        step2View.backgroundColor = ThemeManager.colorPalette?.buttonBorderIconColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderIconColor ?? "")
        step3View.backgroundColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "")
        
        ThemeManager.setShadow(element: containerView,
                               shadowRadius: CGFloat(11),
                               xOffset: 0, yOffset: 0,
                               color: .black, opacity: 1,
                               cornerRadius: 8,
                               masksToBounds: false)
        
    }
    
    private func setupPlacedActive() {
        step1View.backgroundColor = ThemeManager.colorPalette?.buttonBorderIconColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderIconColor ?? "")
        step2View.backgroundColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "")
        step3View.backgroundColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "")
    }
    
    private func setupArrivingActive() {
        step1View.backgroundColor = ThemeManager.colorPalette?.buttonBorderIconColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderIconColor ?? "")
        step2View.backgroundColor = ThemeManager.colorPalette?.buttonBorderIconColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderIconColor ?? "")
        step3View.backgroundColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "")
    }
    
    private func setupDeliveredActive() {
        step1View.backgroundColor = ThemeManager.colorPalette?.buttonBorderIconColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderIconColor ?? "")
        step2View.backgroundColor = ThemeManager.colorPalette?.buttonBorderIconColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderIconColor ?? "")
        step3View.backgroundColor = ThemeManager.colorPalette?.buttonBorderIconColor?.toUIColor(hexa: ThemeManager.colorPalette?.buttonBorderIconColor ?? "")
    }
    
    private func setupCancelledActive() {
        step1View.backgroundColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "")
        step2View.backgroundColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "")
        step3View.backgroundColor = ThemeManager.colorPalette?.tabsInactiveBorder?.toUIColor(hexa: ThemeManager.colorPalette?.tabsInactiveBorder ?? "")
    }
    
    private func bindData() {
        if let model = orderModel {
            orderStatusLabel.text = model.status
            
            switch model.status {
            case OrderStatus.placed.rawValue:
                orderStatusImageView.image = Asset.icPlaced.image
                setupPlacedActive()
            case OrderStatus.delivered.rawValue:
                orderStatusImageView.image = Asset.icDelivered.image
                setupDeliveredActive()
            case OrderStatus.arriving.rawValue:
                orderStatusImageView.image = Asset.icArriving.image
                setupArrivingActive()
            case OrderStatus.canceled.rawValue:
                orderStatusImageView.image = Asset.icCancelled.image
                setupCancelledActive()
            default:
                return
            }
        }
    }
}
