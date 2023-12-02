//
//  WishListViewModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 02/12/2023.
//

import Foundation

class WishListViewModel: BaseViewModel {
    
    weak var service: WishListWebServiceProtocol?

    public var onWishList: (() -> Void)?
    var products: [ProductModel]?

    init(service: WishListWebServiceProtocol = WishListWebService.shared) {
        super.init(observationType: .all)
        self.service = service
    }
    
    func getWishList() {
        guard let service = service else {
            return
        }
        service.getWishList{ (result) in
            switch result {
            case .success(let response):
                self.products = self.getProductsWithCartQuantity(products: response.data ?? [])
                self.products = self.getProductsWithFavorites(products: self.products ?? [])
                self.onWishList?()
            case .failure(let error):
                print(error)
                if error.message != "Request explicitly cancelled." {
                    self.onNetworkError?(error)
                }
            }
        }
    }
    
}
