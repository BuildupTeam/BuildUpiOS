//
//  CartViewModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 19/09/2023.
//

import Foundation

class CartViewModel: BaseViewModel {
    
    weak var service: CartWebServiceProtocol?
    var cartModel: CartModel?
    var cartSettings: SettingsConfigurationModel?

    public var onCart: (() -> Void)?

    init(service: CartWebServiceProtocol = CartWebService.shared) {
        super.init(observationType: .all)
        self.service = service
//        self.getCachedData()
    }
    
    func getCart() {
        guard let service = service else {
            return
        }
        
        service.getCart() { (result) in
            switch result {
            case .success(let response):
                self.cartModel = response.data
                self.getFavoriteProductsUUIDS()
                self.cartModel?.products = self.getProductsWithFavorites(products: self.cartModel?.products ?? [])
                self.onCart?()
            case .failure(let error):
                print(error)
                if error.message != "Request explicitly cancelled." {
                    self.onNetworkError?(error)
                }
            }
        }
    }
    
    func getFavoriteProductsUUIDS() {
        ObservationService.observeOnFavorite()
        RealTimeDatabaseService.getFavoriteProductsFromFirebase { favoriteIDS in
            NotificationCenter.default.post(name: .favoriteUpdated, object: nil, userInfo: nil)
        }
    }
    
    func getCachedData() {
        if let settings = CachingService.getThemeData()?.pages?.first(where: {$0.page == PageName.cart.rawValue})?.settings {
            self.cartSettings = settings
        }
    }
}
