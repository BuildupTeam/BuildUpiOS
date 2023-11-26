//
//  ProductListViewModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 15/09/2023.
//

import Foundation

class ProductListViewModel: BaseViewModel {
    
    weak var service: ProductListWebServiceProtocol?
    
    // MARK: - Model
    var productListSettings: SettingsConfigurationModel?
    var products: [ProductModel] = []
    var page = 1
    var totalCount: Int = 0
    var perPage: Int = 20
    var homeSectionModel: HomeSectionModel?
    var componentModel: ComponentConfigurationModel?

    public var onProducts: (() -> Void)?
    public var onLoadMoreProducts: (() -> Void)?
    
    init(service: ProductListWebServiceProtocol = ProductListWebService.shared) {
        super.init(observationType: .all)
        self.service = service
        self.getCachedData()
    }
    
    func getProducts(productModel: ProductModel,
                     currentPageCompletion: @escaping (() -> String)) {
        
        guard let service = service else {
            return
        }
        service.getProductList(perPage: perPage, page: page, productModel: productModel) { (result) in
            switch result {
            case .success(let response):
                if (response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300 {
//                    guard let currentPage = Int(currentPageCompletion()) else { return }
                    if (response.meta?.currentPage ?? 0) == 1 {
                        //self.products = response.data ?? []
                        self.products = self.getProductsWithCartQuantity(products: response.data ?? [])
                        self.onProducts?()
                    } else if (response.meta?.currentPage ?? 0) > 1 {
                        self.products.append(contentsOf: response.data ?? [])
                        self.onLoadMoreProducts?()
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
    
    func getComponentProductList(componentModel: ComponentConfigurationModel,
                     currentPageCompletion: @escaping (() -> String)) {
        
        guard let service = service else {
            return
        }
        service.getComponentProductList(perPage: perPage, page: page, componentModel: componentModel) { (result) in
            switch result {
            case .success(let response):
                if (response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300 {
                    if (response.meta?.currentPage ?? 0) == 1 {
                        //self.products = response.data ?? []
                        self.products = self.getProductsWithCartQuantity(products: response.data ?? [])
                        self.onProducts?()
                    } else if (response.meta?.currentPage ?? 0) > 1 {
                        self.products.append(contentsOf: response.data ?? [])
                        self.onLoadMoreProducts?()
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
    
    func getCachedData() {
        if let settings = CachingService.getThemeData()?.pages?.first(where: {$0.page == PageName.productList.rawValue})?.settings {
            self.productListSettings = settings
        }
    }
}
