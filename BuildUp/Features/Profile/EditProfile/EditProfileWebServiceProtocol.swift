//
//  EditProfileWebServiceProtocol.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 06/12/2023.
//

import Foundation
import ObjectMapper
import Moya

protocol EditProfileWebServiceProtocol: AnyObject {
    func uploadProfilePicture(data: Data, completion: @escaping ((Result<UpdateProfilePictureResponseModel, NetworkError>) -> Void))
    func updateProfile(model: EditProfileModel, compeltion: @escaping ((Result<ProfileResponseModel, NetworkError>) -> Void))
}

class EditProfileWebService: EditProfileWebServiceProtocol {
    
    static let shared = EditProfileWebService()
    
    func uploadProfilePicture(data: Data, completion: @escaping ((Result<UpdateProfilePictureResponseModel, NetworkError>) -> Void)) {
        MainWebService.fetch(
            endPoint: RouteUpdateProfileApi.uploadProfilePicture(data: data)) { (result, statusCode) in
                switch result {
                case .success(let response):
                    guard let uploadImageResponse = Mapper<UpdateProfilePictureResponseModel>().map(JSONObject: response) else {
                        return
                    }
                    uploadImageResponse.statusCode = statusCode
                    completion(Result.success(uploadImageResponse))
                case .failure(var error):
                    error.statusCode = statusCode
                    completion(Result.failure(error))
                }
            }
    }
    
    func updateProfile(model: EditProfileModel, compeltion: @escaping ((Result<ProfileResponseModel, NetworkError>) -> Void)) {
        MainWebService.fetch(endPoint: RouteUpdateProfileApi.updateProfile(userModel: model)) { (result, statusCode) in
            switch result {
            case .success(let response):
                guard let profileResponse = Mapper<ProfileResponseModel>().map(JSONObject: response) else {
                    return
                }
                profileResponse.statusCode = statusCode
                compeltion(Result.success(profileResponse))
            case .failure(var error):
                error.statusCode = statusCode
                compeltion(Result.failure(error))
            }
        }
    }
}
