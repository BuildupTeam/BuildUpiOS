//
//  CategoriesTabViewModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 19/09/2023.
//

import Foundation

class CategoriesTabViewModel: BaseViewModel {
    
    weak var service: CategoriesTabWebServiceProtocol?
    
    // MARK: - Model
    var categoryListSettings: SettingsConfigurationModel?
    var categories: [CategoryModel] = []
    var categoryModel: CategoryModel? {
        didSet {
            self.getProducts(page: page)
        }
    }
    var products: [ProductModel] = []
    var totalCount: Int = 0
    var limit = 20
    var page = 1
    var perPage: Int = 20
    
    public var onCategories: (() -> Void)?
    public var onProducts: (() -> Void)?
    public var onLoadMoreProducts: (() -> Void)?
    
    init(service: CategoriesTabWebServiceProtocol = CategoriesTabWebService.shared) {
        super.init(observationType: .all)
        self.service = service
    }
    
    func getCategories() {
        guard let service = service else {
            return
        }
        service.getCategories(limit: limit) { (result) in
            switch result {
            case .success(let response):
                if (response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300 {
                    self.categories = response.data ?? []
                    self.categories.first?.isSelected = true
                    self.categoryModel = self.categories.first
                    self.onCategories?()
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
    
    func getProducts(page: Int) {
        guard let model = categoryModel else { return }
        
        guard let service = service else {
            return
        }
        
        service.getProductList(perPage: perPage, page: page, categoryModel: model) { (result) in
            switch result {
            case .success(let response):
                if (response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300 {
                    if (response.meta?.currentPage ?? 0) == 1 {
                        self.products = self.getProductsWithCartQuantity(products: response.data ?? [])
                        self.products = self.getProductsWithFavorites(products: self.products)
                        self.onProducts?()
                    } else if (response.meta?.currentPage ?? 0) > 1 {
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
        if let settings = CachingService.getThemeData()?.pages?.first(where: {$0.page == PageName.categoriesTab.rawValue})?.settings {
            self.categoryListSettings = settings
        }
    }
    
    func getSelectedCategoryModel() -> CategoryModel? {
        return self.categories.first(where: {$0.isSelected})
    }
}
