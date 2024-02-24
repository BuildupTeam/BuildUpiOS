//
//  CheckoutHeaderView.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 24/11/2023.
//

import UIKit

class CheckoutStatusView: UIView {
    
    @IBOutlet private weak var shippingView: UIView!
    @IBOutlet private weak var paymentView: UIView!
    @IBOutlet private weak var reviewView: UIView!
    
    @IBOutlet private weak var shippingLabel: UILabel!
    @IBOutlet private weak var paymentLabel: UILabel!
    @IBOutlet private weak var reviewLabel: UILabel!
    @IBOutlet private weak var shippingStep1Label: UILabel!
    @IBOutlet private weak var paymentStep2Label: UILabel!
    @IBOutlet private weak var reviewStep3Label: UILabel!
    
    @IBOutlet private weak var shippingImageView: UIImageView!
    @IBOutlet private weak var paymentImageView: UIImageView!
    
    
    func setupView() {
        shippingLabel.font = .appFont(ofSize: 13, weight: .semiBold)
        paymentLabel.font = .appFont(ofSize: 13, weight: .semiBold)
        reviewLabel.font = .appFont(ofSize: 13, weight: .semiBold)
        shippingStep1Label.font = .appFont(ofSize: 13, weight: .semiBold)
        paymentStep2Label.font = .appFont(ofSize: 13, weight: .semiBold)
        reviewStep3Label.font = .appFont(ofSize: 13, weight: .semiBold)
        
        shippingStep1Label.textAlignment = .center
        paymentStep2Label.textAlignment = .center
        reviewStep3Label.textAlignment = .center
       
        shippingLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        paymentLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        reviewLabel.textColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "")
        
        self.backgroundColor = ThemeManager.colorPalette?.mainBg2?.toUIColor(hexa: ThemeManager.colorPalette?.mainBg2 ?? "")
        
        shippingView.layer.masksToBounds = true
        shippingView.layer.cornerRadius = shippingView.frame.size.width / 2
        
        paymentView.layer.masksToBounds = true
        paymentView.layer.cornerRadius = shippingView.frame.size.width / 2
        
        reviewView.layer.masksToBounds = true
        reviewView.layer.cornerRadius = shippingView.frame.size.width / 2
        
        shippingLabel.text = L10n.Checkout.shipping
        paymentLabel.text = L10n.Checkout.payment
        reviewLabel.text = L10n.Checkout.review
        shippingStep1Label.text = L10n.Checkout.step1
        paymentStep2Label.text = L10n.Checkout.step2
        reviewStep3Label.text = L10n.Checkout.step3
    }
    
    func setupShippingView() {
        shippingStep1Label.textColor = ThemeManager.colorPalette?.buttonTextColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor1 ?? "")
        paymentStep2Label.textColor = ThemeManager.colorPalette?.buttonTextColor4?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor4 ?? "")
        reviewStep3Label.textColor = ThemeManager.colorPalette?.buttonTextColor4?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor4 ?? "")
        
        shippingView.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        paymentView.backgroundColor = ThemeManager.colorPalette?.buttonColor4?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor4 ?? "")
        reviewView.backgroundColor = ThemeManager.colorPalette?.buttonColor4?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor4 ?? "")
    }
    
    func setupPaymentView() {
        shippingStep1Label.text = ""
        
        paymentStep2Label.textColor = ThemeManager.colorPalette?.buttonTextColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor1 ?? "")
        reviewStep3Label.textColor = ThemeManager.colorPalette?.buttonTextColor4?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor4 ?? "")
        
        shippingView.backgroundColor = ThemeManager.colorPalette?.buttonColor2?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor2 ?? "")
        paymentView.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        reviewView.backgroundColor = ThemeManager.colorPalette?.buttonColor4?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor4 ?? "")
        
        shippingImageView.image = Asset.icComplete.image
    }
    
    func setupReviewView() {
        shippingStep1Label.text = ""
        paymentStep2Label.text = ""
        
        reviewStep3Label.textColor = ThemeManager.colorPalette?.buttonTextColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor1 ?? "")
        
        shippingView.backgroundColor = ThemeManager.colorPalette?.buttonColor2?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor2 ?? "")
        paymentView.backgroundColor = ThemeManager.colorPalette?.buttonColor2?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor2 ?? "")
        reviewView.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        
        shippingImageView.image = Asset.icComplete.image
        paymentImageView.image = Asset.icComplete.image
    }
}
