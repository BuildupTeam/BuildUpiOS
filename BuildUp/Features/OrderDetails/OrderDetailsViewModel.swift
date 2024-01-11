//
//  OrderDetailsViewModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 04/12/2023.
//

import Foundation

class OrderDetailsViewModel: BaseViewModel {
    
    weak var service: OrderDetailsWebServiceProtocol?

    public var onOrderDetails: (() -> Void)?
    var orderModel: OrderModel?

    init(service: OrderDetailsWebServiceProtocol = OrderDetailsWebService.shared) {
        super.init(observationType: .all)
        self.service = service
    }
    
    func getOrderDetails() {
        guard let service = service else {
            return
        }
        
        if let model = orderModel, let orderId = model.uuid {
            service.getOrderDetails(orderId: orderId) { result in
                switch result {
                case .success(let response):
                    self.orderModel = response.data
                    self.onOrderDetails?()
                case .failure(let error):
                    print(error)
                    if error.message != "Request explicitly cancelled." {
                        self.onNetworkError?(error)
                    }
                }
            }
        }
    }
    
}
