//
//  CheckoutViewController+Payment.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 03/04/2024.
//

import Foundation
import PaymentSDK
import PassKit
import CryptoSwift
import Foundation
import ObjectMapper
import CryptoKit

extension CheckoutViewController {
    func getPaymentCredentails() {
        if let payment = checkoutModel.paymentMethod, payment.identifier == "cod" {
//            self.viewModel.completeOrder(transactionId: transactionDetails.transactionReference ?? "")
        } else {
            if let model = checkoutModel.paymentMethod {
                if let response = decryptMsg(encryptedString: model.gateway?.config ?? "") {
                    self.profileID = response["profile_id"]
                    self.serverKey = response["server_key"]
                    self.clientKey = response["client_key"]
                    self.region = response["region"]
                    
                    self.payWithCard()
                }
            }
        }
    }
    
    func decryptMsg(encryptedString: String) -> [String: String]? {
        guard let decodedData = Data(base64Encoded: encryptedString) else {
            print("Failed to decode Base64 string")
            return [:]
        }
        
        // Extract the IV, key, and encrypted data based on their positions
        let iv = decodedData.prefix(16)
        let key = decodedData.suffix(32)
        let encryptedData = decodedData.dropFirst(16).dropLast(32)
        
        do {
            let aes = try AES(key: Array(key), blockMode: CTR(iv: Array(iv)), padding: .noPadding)
            let decryptedBytes = try aes.decrypt(Array(encryptedData))
            let decryptedData = Data(decryptedBytes)
            
            if let decryptedString = String(data: decryptedData, encoding: .utf8) {
                print("Decrypted string: \(decryptedString)")
                
                let dict = decryptedString.toJSON() as? [String: String]
                print("dict = \(String(describing: dict))")
                return dict
                
            } else {
                print("Failed to convert decrypted data to string.")
            }
        } catch {
            print("Decryption error: \(error.localizedDescription)")
        }
        
        return [:]
    }
}

// MARK: - Payment
extension CheckoutViewController: PaymentManagerDelegate {
    
    func payWithCard() {
        PaymentManager.startCardPayment(on: self, configuration: getCardConfiguration(),
                                 delegate: self)
    }
    
    func getBillingAddress() -> PaymentSDKBillingDetails {
        let model = checkoutModel //else { return PaymentSDKBillingDetails() }
        
        let name = model.name
        let email = model.email
        let phone = model.phone
        let city = model.address?.city?.name
        let state = model.address?.area?.name
        let countryCode = model.countryCodeText
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
    
    private func getMerchantCountryCode(region: String) -> String {
        if let region = self.region {
            if region.caseInsensitiveCompare("SAU") == .orderedSame {
                return "SA"
            } else {
                return "EG"
            }
        } else {
            return "EG"
        }
        
    }
    
    func getCardConfiguration() -> PaymentSDKConfiguration {
        guard let model = self.viewModel.checkoutData?.order else { return PaymentSDKConfiguration() }
        let countryCode = checkoutModel.countryCodeText ?? "EG"
        let currency = CachingService.getThemeData()?.currency ?? ""
        let languageCode = LocalizationManager.selectedLanguage.code ?? "en"
        let merchantCountryCode = getMerchantCountryCode(region: self.region ?? "")
        
        
        let theme = PaymentSDKTheme.default
        theme.logoImage = UIImage(named: "Logo")
        return PaymentSDKConfiguration(profileID: profileID ?? "",
                                       serverKey: serverKey ?? "",
                                       clientKey: clientKey ?? "",
                                       currency: currency,
                                       amount: model.formattedTotal?.amount ?? 0.0,
                                       merchantCountryCode: countryCode)
        .cartDescription("Flowers")
        .cartID(model.uuid ?? "")
        .screenTitle("Pay with Card")
        .theme(theme)
        .merchantCountryCode(merchantCountryCode)
        .languageCode(languageCode)
        .billingDetails(getBillingAddress())
    }
    
    func paymentManager(didFinishTransaction transactionDetails: PaymentSDK.PaymentSDKTransactionDetails?, error: Error?) {
        if let transactionDetails = transactionDetails {
            print("transactionDetails = \(transactionDetails)")
            print("Response Code: " + (transactionDetails.paymentResult?.responseCode ?? ""))
            print("Result: " + (transactionDetails.paymentResult?.responseMessage ?? ""))
            print("Token: " + (transactionDetails.token ?? ""))
            print("Transaction Reference: " + (transactionDetails.transactionReference ?? ""))
            print("Transaction Time: " + (transactionDetails.paymentResult?.transactionTime ?? "" ))
            
            if transactionDetails.isSuccess() {
                print("Successful transaction")
                self.viewModel.completeOrder(transactionId: transactionDetails.transactionReference ?? "")
            } else {
                self.viewModel.paymentCancelled()
            }
        } else if let error = error {
            showError(message: error.localizedDescription)
        }
    }
}
