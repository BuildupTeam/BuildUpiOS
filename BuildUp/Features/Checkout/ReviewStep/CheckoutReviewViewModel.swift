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
    var checkoutData: CheckoutDataModel?

    public var onSummary: ((SummaryData?) -> Void)?
    public var onErrorMessage: ((String) -> Void)?
    public var onCheckout: ((CheckoutResponseModel) -> Void)?
    public var onPaymentCancelled: (() -> Void)?
    public var onCompleteOrder: (() -> Void)?

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
                if (response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300 {
                    self.summaryData = response.data
                    self.onSummary?(response.data)
                } else {
                    self.onErrorMessage?(response.message ?? "")
                }
                
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
                self.checkoutData = response.data
                self.onCheckout?(response)
            case .failure(let error):
                print(error)
                if error.message != "Request explicitly cancelled." {
                    self.onNetworkError?(error)
                }
            }
        }
    }
    
    func paymentCancelled() {
        guard let checkoutData = self.checkoutData else { return }
        guard let service = service else { return }
        
        service.paymentCancelled(orderUUID: checkoutData.order?.uuid ?? "") { result in
            switch result {
            case .success(_):
                self.onPaymentCancelled?()
            case .failure(let error):
                print(error)
                if error.message != "Request explicitly cancelled." {
                    self.onNetworkError?(error)
                }
            }
        }
    }
    
    func completeOrder(transactionId: String) {
        guard let checkoutData = self.checkoutData else { return }
        guard let service = service else { return }
        
        service.completeOrder(transactionId: transactionId, orderUUID: checkoutData.order?.uuid ?? "") { result in
            switch result {
            case .success(_):
                self.onCompleteOrder?()
            case .failure(let error):
                print(error)
                if error.message != "Request explicitly cancelled." {
                    self.onNetworkError?(error)
                }
            }
        }
    }
}
