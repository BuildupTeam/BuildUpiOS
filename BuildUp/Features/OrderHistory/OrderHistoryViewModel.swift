//
//  OrderHistoryViewModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 29/11/2023.
//

import Foundation

class OrderHistoryViewModel: BaseViewModel {
    
    weak var service: OrderHistoryWebServiceProtocol?
    var orders: [OrderModel] = []
    var onLoadMoreOrders: (() -> Void)?
    var responseModel: OrdersResponseModel?

    var page = 1
    var perPage: Int = 10
    var cursor: String?

    public var onOrders: (() -> Void)?

    init(service: OrderHistoryWebServiceProtocol = OrderHistoryWebService.shared) {
        super.init(observationType: .all)
        self.service = service
    }
    
    func getOrders(completed: Int) {
        guard let service = service else {
            return
        }
        
        service.getOrders(completed: completed, perPage: perPage, page: page, cursor: cursor) { (result) in
            switch result {
            case .success(let response):
                if (response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300 {
                    self.responseModel = response
                    self.cursor = response.pagination?.cursorMeta?.nextCursor
                    
                    if self.page == 1  {
                        self.orders = response.data ?? []
                        self.onOrders?()
                    } else {
                        self.orders.append(contentsOf: response.data ?? [])
                        self.onLoadMoreOrders?()
                    }
                } else {
                    self.handleError(response: response)
                }
            case .failure(let error):
                print(error)
                if error.message != "Request explicitly cancelled." {
                    self.onNetworkError?(error)
                }
            }
        }
    }
}
