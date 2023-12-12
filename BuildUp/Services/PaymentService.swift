//
//  PaymentService.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 12/12/2023.
//

import Foundation
import PaymentSDK
import PassKit

class PaymentService {
    static let shared = PaymentService()
    
    let profileID = "134477"
    let serverKey = "S2J99KHW2M-JHJWBG99GD-GKG62BR2L9"
    let clientKey = "CBK22V-V7TR6H-6V2TPP-TVQGBV"
    
    var checkoutModel: CheckoutModel?
    var summaryModel: SummaryModel?
    
    func getBillingAddress() -> PaymentSDKBillingDetails {
        guard let model = checkoutModel else { return PaymentSDKBillingDetails() }
        let name = model.name
        let email = model.email
        let phone = model.phone
        let city = model.address?.city?.name
        let state = model.address?.area?.name
        let countryCode = model.countryCode
        let addressLine = model.address?.addressDescription
        
        return PaymentSDKBillingDetails(name: name,
                                        email: email,
                                        phone: phone,
                                        addressLine: addressLine,
                                        city: city,
                                        state: state,
                                        countryCode: countryCode,
                                        zip: "12345")
    }
    
    func getCardConfiguration() -> PaymentSDKConfiguration {
        guard let model = summaryModel else { return PaymentSDKConfiguration() }
        let theme = PaymentSDKTheme.default
        theme.logoImage = UIImage(named: "Logo")
        return PaymentSDKConfiguration(profileID: profileID,
                                       serverKey: serverKey,
                                       clientKey: clientKey,
                                       currency: "SAR",
                                       amount: model.subtotal ?? 0.0,
                                       merchantCountryCode: "AE")
            .cartDescription("Flowers")
            .cartID("1234")
            .screenTitle("Pay with Card")
            .theme(theme)
            .billingDetails(getBillingAddress())
    }
    
//    func payWithCard() {
//        PaymentManager.startCardPayment(on: self, configuration: getCardConfiguration(),
//                                 delegate: self)
//    }
}

extension PaymentService: PaymentManagerDelegate {
    func paymentManager(didFinishTransaction transactionDetails: PaymentSDK.PaymentSDKTransactionDetails?, error: Error?) {
        
    }
}
