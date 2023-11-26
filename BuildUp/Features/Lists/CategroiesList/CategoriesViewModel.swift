//
//  CategoriesViewModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 18/09/2023.
//

import Foundation

class CategoriesViewModel: BaseViewModel {
    
    weak var service: CategoriesWebServiceProtocol?
    
    // MARK: - Model
    var categoryListSettings: SettingsConfigurationModel?
    var categories: [CategoryModel] = []
    var page = 1
    var totalCount: Int = 0
    var perPage: Int = 20
    var homeSectionModel: HomeSectionModel?

    public var onCategories: (() -> Void)?
    public var onLoadMoreCategories: (() -> Void)?
    
    init(service: CategoriesWebServiceProtocol = CategoriesWebService.shared) {
        super.init(observationType: .all)
        self.service = service
        self.getCachedData()
    }
    
    func getCategories(componentModel: ComponentConfigurationModel,
                       currentPageCompletion: @escaping (() -> String)) {
        
        guard let service = service else {
            return
        }
        
        service.getCategoriesList(perPage: perPage, page: page, componentModel: componentModel) { (result) in
            switch result {
            case .success(let response):
                if (response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300 {
                    guard let currentPage = Int(currentPageCompletion()) else { return }
                    if (response.meta?.currentPage ?? 0) == 1 {
                        self.categories = response.data ?? []
                        self.onCategories?()
                    } else if (response.meta?.currentPage ?? 0) > 1 {
                        self.categories.append(contentsOf: response.data ?? [])
                        self.onLoadMoreCategories?()
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
            self.categoryListSettings = settings
        }
    }
}
