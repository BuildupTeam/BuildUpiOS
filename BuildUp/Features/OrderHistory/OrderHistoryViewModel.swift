//
//  OrderHistoryViewModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 29/11/2023.
//

import Foundation

class OrderHistoryViewModel: BaseViewModel {
    
    weak var service: OrderHistoryWebServiceProtocol?
    var orders: [OrderModel]?

    public var onOrders: (() -> Void)?

    init(service: OrderHistoryWebServiceProtocol = OrderHistoryWebService.shared) {
        super.init(observationType: .all)
        self.service = service
    }
    
    func getOrders(completed: Int) {
        guard let service = service else {
            return
        }
        
        service.getOrders(completed: completed) { (result) in
            switch result {
            case .success(let response):
                self.orders = response.data
                self.onOrders?()
            case .failure(let error):
                print(error)
                if error.message != "Request explicitly cancelled." {
                    self.onNetworkError?(error)
                }
            }
        }
    }
}
