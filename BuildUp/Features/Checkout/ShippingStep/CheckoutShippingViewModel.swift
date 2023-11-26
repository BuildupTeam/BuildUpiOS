//
//  CheckoutShippingViewModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 25/11/2023.
//

import Foundation

class CheckoutShippingViewModel: BaseViewModel {
    
    weak var service: CheckoutShippingWebServiceProtocol?
    var addresses: [AddressModel]?

    public var onAddresses: (() -> Void)?

    init(service: CheckoutShippingWebServiceProtocol = CheckoutShippingWebService.shared) {
        super.init(observationType: .all)
        self.service = service
    }
    
    func getAddresses() {
        guard let service = service else {
            return
        }
        
        service.getAddresses() { (result) in
            switch result {
            case .success(let response):
                self.addresses = response.data
                self.onAddresses?()
            case .failure(let error):
                print(error)
                if error.message != "Request explicitly cancelled." {
                    self.onNetworkError?(error)
                }
            }
        }
    }
}
