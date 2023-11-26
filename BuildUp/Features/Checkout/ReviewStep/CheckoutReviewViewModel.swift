//
//  CheckoutReviewViewModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 25/11/2023.
//

import Foundation

class CheckoutReviewViewModel: BaseViewModel {
    
    weak var service: CheckoutReviewWebServiceProtocol?
    var countries: [CountryModel]?

    public var onCountries: (() -> Void)?

    init(service: CheckoutReviewWebServiceProtocol = CheckoutReviewWebService.shared) {
        super.init(observationType: .all)
        self.service = service
    }
    
//    func continueCheckout() {
//        guard let service = service else {
//            return
//        }
//        
//        service.getCountries() { (result) in
//            switch result {
//            case .success(let response):
//                self.countries = response.data
//                self.onCountries?()
//            case .failure(let error):
//                print(error)
//                if error.message != "Request explicitly cancelled." {
//                    self.onNetworkError?(error)
//                }
//            }
//        }
//    }
}
