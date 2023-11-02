//
//  RegisterViewModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 30/10/2023.
//

import Foundation

class RegisterViewModel: BaseViewModel {
    
    weak var service: RegisterWebServiceProtocol?

    // MARK: - Model
    var registerModel: RegisterModel?

    public var onRegister: (() -> Void)?
    
    init(service: RegisterWebServiceProtocol = RegisterWebService.shared) {
        super.init(observationType: .all)
        self.service = service
    }
    
    func registerUser(model: RegisterModel) {
        
        guard let service = service else {
            return
        }
        
        service.registerNewUser(model: model) { (result) in
            switch result {
            case .success(let response):
                if (response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300 {
                    if let userModel = response.data {
                        CachingService.setUser(userModel)
                    }
                    self.onRegister?()
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
