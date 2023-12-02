//
//  CheckoutReviewViewModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 25/11/2023.
//

import Foundation

class CheckoutReviewViewModel: BaseViewModel {
    
    weak var service: CheckoutReviewWebServiceProtocol?
    var summaryData: SummaryData?

    public var onSummary: (() -> Void)?
    public var onCheckout: (() -> Void)?

    init(service: CheckoutReviewWebServiceProtocol = CheckoutReviewWebService.shared) {
        super.init(observationType: .all)
        self.service = service
    }
    
    func getSummary(_ addressId: Int) {
        guard let service = service else {
            return
        }
        
        service.getSummary(addressId: addressId) { (result) in
            switch result {
            case .success(let response):
                self.summaryData = response.data
                self.onSummary?()
            case .failure(let error):
                print(error)
                if error.message != "Request explicitly cancelled." {
                    self.onNetworkError?(error)
                }
            }
        }
    }
    
    func checkout(model: CheckoutModel) {
        guard let service = service else {
            return
        }
        
        service.checkout(checkoutModel: model) { (result) in
            switch result {
            case .success(let response):
                self.onCheckout?()
            case .failure(let error):
                print(error)
                if error.message != "Request explicitly cancelled." {
                    self.onNetworkError?(error)
                }
            }
        }
    }
}
