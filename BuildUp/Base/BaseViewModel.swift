//
//  BaseViewModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 20/05/2023.
//

import Foundation
import Moya

enum ObservationType {
    case cartUpdated
    case all
}

class BaseViewModel {
    
    weak var baseService: BaseWebServiceProtocol?
        
    var onNetworkError: ((NetworkError?) -> Void)?
    var onBusinessError: ((String?) -> Void)?
    var onAuthenticationError: (() -> Void)?
    var onForceUpdate: ((BaseResponse) -> Void)?
    var onUserData: (() -> Void)?
    var observationType: ObservationType
    var onAdStatusChanged: (() -> Void)?
    var onAdStatusWarning: (() -> Void)?
    var carItemUpdated: (() -> Void)?

    var adModelToUpdate: AdModel?
    
    init(service: BaseWebServiceProtocol = BaseWebService.baseShared, observationType: ObservationType = .all) {
        self.baseService = service
        self.observationType = observationType
        
        if observationType == .cartUpdated {
            observeOnCart()
        }
    }
    
    deinit {
        removeCartObservations()
    }
    
    func getUserData() {
        /*
        guard let baseService = baseService else {
            return
        }
        
        baseService.getUser { (result) in
            
            switch result {
            case .success(let response):
                if let newUserModel = response.data, let oldUserModel = CachingService.getUser() {
                    
                    oldUserModel.accessToken = newUserModel.accessToken
                    oldUserModel.email = newUserModel.email
                    oldUserModel.phone = newUserModel.phone
                    oldUserModel.userName = newUserModel.userName
                    oldUserModel.wallet = newUserModel.wallet
                    oldUserModel.facebookPage = newUserModel.facebookPage
                    oldUserModel.currency = newUserModel.currency
                    oldUserModel.referenceNo = newUserModel.referenceNo
                    oldUserModel.promoCode = newUserModel.promoCode
                    oldUserModel.isEmailVerified = newUserModel.isEmailVerified
                    oldUserModel.cashBack = newUserModel.cashBack
                    CachingService.setUser(oldUserModel)
//                    AppAnalyticsService.identifyCustomerIoUser()
//                    AppAnalyticsService.currentBalanceEvent(balance: "\(newUserModel.wallet ?? 0.0)")
                }
//                self.intercomeLogin()
                self.onUserData?()
                
            case .failure(let error):
                print(error)
                if error.message != "Request explicitly cancelled." {
                    self.onNetworkError?(error)
                }
            }
        }
        */
    }
    
    /*
    
    func registerFCMToken(token: String) {
        
        guard let service = baseService else {
            return
        }
        
        service.registerFCMToken(token: token) { (result) in
            
            switch result {
            case .success(let response):
                if (response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300 {
                    self.onRegisterTokenResponse?()
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
    
    func deleteFCMToken() {
        
        guard let service = baseService else {
            return
        }
        
        service.deleteFCMToken { (result) in
            
            switch result {
            case .success(let response):
                if (response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300 {
                    self.onDeleteTokenResponse?()
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
    
    func deleteAccount() {
        
        guard let service = baseService else {
            return
        }
        
        service.deleteAccount { result in
            switch result {
            case .success(let response):
                if (response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300 {
                    self.onDeleteAccount?()
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
    
    func verifyEmail(email: String) {
        
        guard let service = baseService else {
            return
        }
        
        service.verifyEmail(email: email) { result in
            switch result {
            case .success(let response):
                if (response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300 {
                    self.onVerifyEmail?()
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
    
    func getVerifyEmail() {
        
        guard let service = baseService else {
            return
        }
        
        service.getVerifyEmail { result in
            switch result {
            case .success(let response):
                if (response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300 {
                    
                    if response.data?.isEmailVerified ?? false {
                        self.onIsVerifyEmail?()
                    } else {
                        self.onIsNotVerifyEmail?()
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
    */
}

// MARK: - Firebase RealTimeDatabase
extension BaseViewModel {
    func getProductsWithCartQuantity(products: [ProductModel]) -> [ProductModel] {
        guard let defaultCartProducts = CachingService.getDefaultCartProducts() else { return products }
        for product in products {
            guard let uuid = product.uuid else { return [] }
            if defaultCartProducts[uuid] != nil {
                if let values = defaultCartProducts[uuid] {
                    product.cartQuantity = values["default"] ?? 0
                }
            }
        }
        
        return products
    }
}

// MARK: - Error Handling
extension BaseViewModel {
    func handleError(response: BaseResponse) {
        if response.statusCode == 401 {
            self.onAuthenticationError?()
        } else {
            if response.code == 12 {
                self.onForceUpdate?(response)
            } else {
                self.onBusinessError?(response.message ?? "")
            }
        }
    }
}

// MARK: - Firebase & Observation Handler
extension BaseViewModel {
    func observeOnCart() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cartUpdatedAction(_:)),
            name: .cartupdated,
            object: nil)
    }
    
    @objc
    func cartUpdatedAction(_ notification: Notification) {
        self.carItemUpdated?()
//        removeCartObservations()
    }
    
    func removeCartObservations() {
        NotificationCenter.default.removeObserver(self, name: .cartupdated, object: nil)
    }
}
