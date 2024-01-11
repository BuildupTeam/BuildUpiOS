//
//  CheckoutPaymentViewModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 25/11/2023.
//

import Foundation

class CheckoutPaymentViewModel: BaseViewModel {
    
    weak var service: CheckoutPaymentWebServiceProtocol?
    var paymentMethods: [PaymentMethodModel]?

    public var onPaymentMethods: (() -> Void)?

    init(service: CheckoutPaymentWebServiceProtocol = CheckoutPaymentWebService.shared) {
        super.init(observationType: .all)
        self.service = service
    }
    
    func getPaymentMethods(countryCode: String) {
        guard let service = service else {
            return
        }
        
        service.getPaymentMethods(countryCode: countryCode) { (result) in
            switch result {
            case .success(let response):
                self.paymentMethods = response.data
                self.onPaymentMethods?()
            case .failure(let error):
                print(error)
                if error.message != "Request explicitly cancelled." {
                    self.onNetworkError?(error)
                }
            }
        }
    }
}
