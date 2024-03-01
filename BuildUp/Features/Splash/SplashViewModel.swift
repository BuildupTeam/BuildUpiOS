//
//  SplashViewModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 01/03/2024.
//

import Foundation

class SplashViewModel: BaseViewModel {
    weak var service: SubdomainWebServiceProtocol?

    public var onData: (() -> Void)?
    
    init(service: SubdomainWebServiceProtocol = SubdomainWebService.shared) {
        super.init(observationType: .all)
        self.service = service
    }

    func getHomeTemplate() {
        guard let service = service else {
            return
        }
        service.getHomeTemplate() { (result) in
            switch result {
            case .success(let response):
                if (response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300 {
                    self.cacheThemeData(response.data)
                    self.onData?()
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
    
    func cacheThemeData(_ theme: ThemeConfigurationDataModel?) {
        if let theme = theme {
            CachingService.setThemeData(theme: theme)
        }
    }
}
