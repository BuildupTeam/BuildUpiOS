//
//  CategoryDetailsViewModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 16/09/2023.
//

import Foundation
class CategoryDetailsViewModel: BaseViewModel {
    
    weak var service: CategoryDetailsWebServiceProtocol?
    
    // MARK: - Model
    var categoryDetailsSettings: SettingsConfigurationModel?
    var categoryModel: CategoryModel?
    
    var subCategories: [CategoryModel] = []
    var products: [ProductModel] = []
    
    var page = 1
    var totalCount: Int = 0
    var perPage: Int = 20
    var responseModel: ProductsResponseModel?
    var cursor: String?
    
    public var onProducts: (() -> Void)?
    public var onLoadMoreProducts: (() -> Void)?
    
    public var onSubCategories: (() -> Void)?
    
    init(service: CategoryDetailsWebServiceProtocol = CategoryDetailsWebService.shared) {
        super.init(observationType: .all)
        self.service = service
        self.getCachedData()
    }
    
    func getSubCategories() {
        
        guard let service = service else {
            return
        }
        
        if let categoryModel = categoryModel {
            service.getCategoryDetails(parentId: categoryModel.id ?? 0) { (result) in
                switch result {
                case .success(let response):
                    if (response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300 {
                        self.subCategories = response.data ?? []
                        self.onSubCategories?()
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
    
    func getProducts(categoryId: Int ,componentModel: ComponentConfigurationModel,
                     currentPageCompletion: @escaping (() -> String)) {
        
        guard let service = service else {
            return
        }
        service.getProductList(categoryId: categoryId, perPage: perPage, page: page, componentModel: componentModel) { (result) in
            switch result {
            case .success(let response):
                if (response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300 {
                    self.responseModel = response
                    self.cursor = self.responseModel?.pagination?.cursorMeta?.nextCursor
                    
                    if self.page == 1 {
                        self.products = self.getProductsWithCartQuantity(products: response.data ?? [])
                        self.products = self.getProductsWithFavorites(products: self.products)
                        self.onProducts?()
                    } else {
                        self.products.append(contentsOf: self.getProductsWithCartQuantity(products: response.data ?? []))
                        self.products = self.getProductsWithFavorites(products: self.products)
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
        if let settings = CachingService.getThemeData()?.pages?.first(where: {$0.page == PageName.categoryDetails.rawValue})?.settings {
            self.categoryDetailsSettings = settings
        }
    }
    
}
