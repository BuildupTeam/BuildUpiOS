//
//  LoginViewModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 30/10/2023.
//

import Foundation

class LoginViewModel: BaseViewModel {
    
    weak var service: LoginWebServiceProtocol?

    public var onLogin: (() -> Void)?
    
    init(service: LoginWebServiceProtocol = LoginWebService.shared) {
        super.init(observationType: .all)
        self.service = service
    }
    
    func loginUser(model: LoginModel) {
        guard let service = service else {
            return
        }
        
        service.login(model: model) { (result) in
            switch result {
            case .success(let response):
                if (response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300 {
                    if let userModel = response.data {
                        CachingService.setUser(userModel)
                    }
                    self.onLogin?()
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
