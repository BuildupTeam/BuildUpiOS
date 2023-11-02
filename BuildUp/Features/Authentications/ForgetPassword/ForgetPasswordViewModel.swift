//
//  ForgetPasswordViewModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 01/11/2023.
//

import Foundation

class ForgetPasswordViewModel: BaseViewModel {
    
    weak var service: ForgetPasswordWebServiceProtocol?
        
    public var onForgetPassword: (() -> Void)?
    
    init(service: ForgetPasswordWebServiceProtocol = ForgetPasswordWebService.shared) {
        super.init(observationType: .all)
        self.service = service
    }
    
    func forgetPassword(email: String) {
        guard let service = service else {
            return
        }
        
        service.forgetPassword(email: email) { (result) in
            switch result {
            case .success(let response):
                if (response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300 {
                    self.onForgetPassword?()
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
