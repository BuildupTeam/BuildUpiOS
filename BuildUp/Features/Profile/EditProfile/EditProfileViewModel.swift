//
//  EditProfileViewModel.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 06/12/2023.
//

import Foundation

class EditProfileViewModel: BaseViewModel {
    
    weak var service: EditProfileWebServiceProtocol?

    // MARK: - Model
    var customerModel: CustomerModel?

    public var onUpdateProfile: (() -> Void)?
    var onUploadProfilePicture: ((UpdateProfilePictureResponseModel) -> Void)?

    init(service: EditProfileWebServiceProtocol = EditProfileWebService.shared) {
        super.init(observationType: .all)
        self.service = service
    }
    
    func updateProfile(model: EditProfileModel) {
        
        guard let service = service else {
            return
        }
        
        service.updateProfile(model: model) { (result) in
            switch result {
            case .success(let response):
                if (response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300 {
                    self.onUpdateProfile?()
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
    
    func uploadProfilePicture(_ data: Data) {
        guard let service = service else { return }
        
        service.uploadProfilePicture(data: data) { result in
            switch result {
            case .success(let response):
                if (response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300 {
                    self.onUploadProfilePicture?(response)
                } else {
                    self.handleError(response: response)
                }
            case .failure(let error):
                self.onNetworkError?(error)
            }
        }
    }
}
