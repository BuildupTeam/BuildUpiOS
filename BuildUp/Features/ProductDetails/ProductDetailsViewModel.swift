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
                    if let files = self.productModel?.files, !files.isEmpty {
//                        let fileModel = ProductFileModel(
                        for (index, file) in files.enumerated() {
                            if index == 0 {
                                file.isSelected = true
                            }
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
        service.getRelatedProducts(limit: limit) { (result) in
            switch result {
            case .success(let response):
                if (response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300 {
                    self.productModel?.relatedProducts = response.data
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
    
    func getCachedData() {
        if let settings = CachingService.getThemeData()?.pages?.first(where: {$0.page == PageName.productDetails.rawValue})?.settings {
            self.productDetailsSettings = settings
            viewTitle = CachingService.getThemeData()?.pages?.first(where: {$0.page == PageName.productDetails.rawValue})?.page
        }
    }
}
