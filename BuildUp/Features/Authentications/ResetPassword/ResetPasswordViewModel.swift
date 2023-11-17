//
//  ResetPasswordViewModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 01/11/2023.
//

import Foundation

class ResetPasswordViewModel: BaseViewModel {
    
    weak var service: ResetPasswordWebServiceProtocol?
        
    public var onResetPassword: (() -> Void)?
    
    init(service: ResetPasswordWebServiceProtocol = ResetPasswordWebService.shared) {
        super.init(observationType: .all)
        self.service = service
    }
    
    func resetPassword(email: String, password: String, code: String) {
        guard let service = service else {
            return
        }
        
        service.resetPassword(email: email, password: password, code: code) { (result) in
            switch result {
            case .success(let response):
                if (response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300 {
                    self.onResetPassword?()
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
