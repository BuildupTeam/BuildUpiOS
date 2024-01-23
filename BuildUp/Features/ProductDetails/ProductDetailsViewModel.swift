//
//  ProductDetailsViewModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 01/09/2023.
//

import Foundation

class ProductDetailsViewModel: BaseViewModel {
    
    weak var service: ProductDetailsWebServiceProtocol?
    
    // MARK: - Model
    var productModel: ProductModel?
    var productDetailsSettings: SettingsConfigurationModel?
    var selectedOptionsValues: [String: String] = [:]
    
    var componentModel: ComponentConfigurationModel?
    var viewTitle: String?
    
    // MARK: - Data Observables
    public var onData: (() -> Void)?
    public var onRelatedProducts: (() -> Void)?
    
    init(service: ProductDetailsWebServiceProtocol = ProductDetailsWebService.shared) {
        super.init(observationType: .all)
        self.service = service
        self.getCachedData()
    }
    
    func getVaialbleCombinations(productModel: ProductModel) -> [ProductDetailsCombinationsModel]? {
        let combinations = productModel.combinations
        for combination in combinations ?? [] {
            let combinationIds = combination.options?.map({$0.optionValueId})
            let selectedValuesIds = selectedOptionsValues.values.map({$0.hashValue})
//            if combinationIds.containsSameElements(as: selectedValuesIds) {
//                return [combination]
//            }
        }
        return []
    }
    
    func getProductDetails(uuid: String) {
        guard let service = service else {
            return
        }
        service.getProductDetails(uuid: uuid) { (result) in
            switch result {
            case .success(let response):
                if (response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300 {
                    self.productModel = response.data
                    self.getFavoriteProductsUUIDS()

                    let favoriteUUIDs = CachingService.getFavoriteProducts()
                    if favoriteUUIDs.contains(self.productModel?.uuid ?? "") {
                        self.productModel?.isFavorite = true
                    } else {
                        self.productModel?.isFavorite = false
                    }
                    
                    if let files = self.productModel?.files {
                        if !files.isEmpty {
                            let fileModel = ProductFileModel(path: self.productModel?.mainImage?.path ?? "")
                            self.productModel?.files?.insert(fileModel, at: 0)
                            for (index, file) in files.enumerated() {
                                if index == 0 {
                                    file.isSelected = true
                                }
                            }
                        } else {
                            let fileModel = ProductFileModel(path: self.productModel?.mainImage?.path ?? "")
                            self.productModel?.files?.insert(fileModel, at: 0)
                        }
                    }
                    
                    self.getRelatedProducts(limit: 10)
                }
            case .failure(let error):
                print(error)
                if error.message != "Request explicitly cancelled." {
                    self.onNetworkError?(error)
                }
            }
        }
    }
    
    func getRelatedProducts(limit: Int) {
        guard let service = service else {
            return
        }
        if let model = productModel {
            service.getRelatedProducts(limit: limit, productModel: model) { (result) in
                switch result {
                case .success(let response):
                    if (response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300 {
                        self.productModel?.relatedProducts = self.getProductsWithCartQuantity(products: response.data ?? [])
                        self.productModel?.relatedProducts = self.getProductsWithFavorites(products: self.productModel?.relatedProducts ?? [])
                        self.onData?()
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
    
    func getFavoriteProductsUUIDS() {
        ObservationService.observeOnFavorite()
        RealTimeDatabaseService.getFavoriteProductsFromFirebase { favoriteIDS in
            NotificationCenter.default.post(name: .favoriteUpdated, object: nil, userInfo: nil)
        }
    }
    
    func updateProductModelWithFavorite() -> ProductModel? {
        let favoriteProducts = CachingService.getFavoriteProducts()
        guard let model = productModel else { return nil }
        guard let uuid = model.uuid else { return model }
        if favoriteProducts.contains(uuid) {
            model.isFavorite = true
        } else {
            model.isFavorite = false
        }
        
        return model
    }
    
    func getCachedData() {
        if let settings = CachingService.getThemeData()?.pages?.first(where: {$0.page == PageName.productDetails.rawValue})?.settings {
            self.productDetailsSettings = settings
            viewTitle = CachingService.getThemeData()?.pages?.first(where: {$0.page == PageName.productDetails.rawValue})?.page
        }
    }
}
