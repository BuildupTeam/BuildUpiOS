//
//  ProfileViewModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 19/09/2023.
//

import Foundation

class ProfileViewModel: BaseViewModel {
    
    weak var service: ProfileWebServiceProtocol?

    public var onProfile: (() -> Void)?
    public var onLogout: (() -> Void)?
    public var onTokenNotExist: (() -> Void)?
    var userModel: CustomerModel?

    init(service: ProfileWebServiceProtocol = ProfileWebService.shared) {
        super.init(observationType: .all)
        self.service = service
    }
    
    func logoutUser() {
        guard let service = service else {
            return
        }
        if let token = CachingService.getUser()?.accessToken {
            service.logoutUser(token: token) { (result) in
                switch result {
                case .success(_):
                    self.onLogout?()
                case .failure(let error):
                    print(error)
                    if error.message != "Request explicitly cancelled." {
                        self.onNetworkError?(error)
                    }
                }
            }
        } else {
            self.onTokenNotExist?()
        }
    }
    
    func getProfile() {
        guard let service = service else {
            return
        }
        
        service.getProfile { result in
            switch result {
            case .success(let response):
                self.userModel = response.data
                if let customer = response.data {
                    if var usermodel = CachingService.getUser() {
                        usermodel.customer = customer
                        CachingService.setUser(usermodel)
                    }
                }
                self.onProfile?()
            case .failure(let error):
                print(error)
                if error.message != "Request explicitly cancelled." {
                    self.onNetworkError?(error)
                }
            }
        }
    }
    
}
