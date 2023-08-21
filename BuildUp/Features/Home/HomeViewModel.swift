//
//  HomeViewModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 21/07/2023.
//

import Foundation

enum HomeContentType: String {
    case products = "products"
    case categories = "categories"
    case banner = "banners"
}

class HomeViewModel: BaseViewModel {
    
    weak var service: HomeWebServiceProtocol?
    
    // MARK: - Model
    var homeData = HomeModel()
    
    // MARK: - Data Observables
    public var onData: (() -> Void)?
    
    init(service: HomeWebServiceProtocol = HomeWebService.shared) {
        super.init(observationType: .all)
        self.service = service
        self.getCachedHomeData()
    }
    
    func getHomeTemplate() {
        guard let service = service else {
            return
        }
        service.getHomeTemplate() { (result) in
            switch result {
            case .success(let response):
                if (response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300 {
                    self.createHomeSectionArray(responseSections: response.data?.pages?.first?.sections ?? [])
                    self.prepareAndRequestHomeApis()
                    self.cacheThemeData(response.data)
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
    
    func getHomeCategories(componentModel: ComponentConfigurationModel) {
        guard let service = service else {
            return
        }
        service.getHomeCategories(limit: 4, componentModel: componentModel) { (result) in
            switch result {
            case .success(let response):
                if (response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300 {
                    
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
    
    func getProducts(limit: Int,
                     componentModel: ComponentConfigurationModel,
                     contentTypeCompletion: @escaping (() -> String),
                     orderCompletion: @escaping (() -> String)) {
        
        guard let service = service else {
            return
        }
        service.getHomeProducts(limit: limit, componentModel: componentModel) { (result) in
            switch result {
            case .success(let response):
                if (response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300 {
                    self.homeData.editHomeSectionsArrayWIthData(
                        contentType: contentTypeCompletion(),
                        order: orderCompletion(),
                        products: response.data ?? [])
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

// MARK: - Prepared Requests
extension HomeViewModel {
    func getHomeProducts(order: String, componentModel: ComponentConfigurationModel) {
        let contentTypeCompletion: (() -> String) = { () in return "\(HomeContentType.products.rawValue)" }
        let orderCompletion: (() -> String) = { () in return "\(order)" }
        
        getProducts(limit: 4,
                    componentModel: componentModel,
                    contentTypeCompletion: contentTypeCompletion,
                    orderCompletion: orderCompletion)
    }
}

// MARK: - Dynamic Components Logic
extension HomeViewModel {
    func createHomeSectionArray(responseSections: [SectionConfigurationModel]) {
        var sections = responseSections
        sections.removeAll { sectionModel in
            sectionModel.components?.isEmpty ?? true
        }
        
        self.homeData.homeSections = []
        
        for (index, section) in sections.enumerated() {
            if let contentType = section.components?.first?.contentType,
               let component = section.components?.first {
                
                let homeSectionModel = HomeSectionModel(order: index, contentType: contentType, component: component)
                self.homeData.homeSections.append(homeSectionModel)
                self.cacheHomeData()
//                self.onData?()
            } else {
                print(section.components?.first?.design ?? "")
            }
        }
    }
    
    func prepareAndRequestHomeApis() {
        for section in homeData.homeSections {
            if let contentType = section.contentType, let order = section.order, let componentModel = section.component {
                switchAndRequest(contentType: contentType, order: "\(order)", componentModel: componentModel)
            }
        }
    }
    
    func switchAndRequest(contentType: String, order: String, componentModel: ComponentConfigurationModel) {
        switch contentType {
        case HomeContentType.products.rawValue:
            self.getHomeProducts(order: order, componentModel: componentModel)
        case HomeContentType.categories.rawValue:
//            self.getHomeCategories(componentModel: componentModel)
            return
        default:
            print("No Such Component")
        }
    }
}

// MARK: - check to Reload
extension HomeViewModel {
    func checkDataAvailability() {
        if homeData.isAllDynamicDataValid {
            self.cacheHomeData()
            self.onData?()
            print("All Data Is Valid")
        }
    }
}

// MARK: - Caching Logic
extension HomeViewModel {
    func cacheHomeData() {
        CachingService.setHomeData(homeSections: homeData.homeSections)
    }
    
    func cacheThemeData(_ theme: ThemeConfigurationDataModel?) {
        if let theme = theme {
            CachingService.setThemeData(theme: theme)
        }
    }
    
    func getCachedHomeData() {
        if let homeSections = CachingService.getHomeData() {
            self.homeData.homeSections = homeSections
            self.onData?()
        }
    }
}
