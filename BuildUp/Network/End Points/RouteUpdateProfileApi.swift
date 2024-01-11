//
//  RouteUpdateProfileApi.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 06/12/2023.
//

import Foundation
import Moya

enum RouteUpdateProfileApi {
    case uploadProfilePicture(data: Data)
    case updateProfile(userModel: EditProfileModel)
}

extension RouteUpdateProfileApi: TargetType {
    var baseURL: URL {
        var configuration = Configuration()
        return URL(string: configuration.environment.baseURL)!
    }
    
    var path: String {
        switch self {
        case .uploadProfilePicture:
            return ApiUrls.Apis.uploadImageUrl
        case .updateProfile:
            return ApiUrls.Apis.updateProfileUrl
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .uploadProfilePicture:
            return .post
        case .updateProfile:
            return .put
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .uploadProfilePicture(data: let data):
            let imageData = MultipartFormData(provider: .data(data), name: "file", fileName: "avatar.jpeg", mimeType: "image/jpeg")
            let multipartData = [imageData]
            return .uploadMultipart(multipartData)
        case .updateProfile(userModel: let model):
            var parameters: [String: Any] = [:]
            
            parameters["full_name"] = model.fullName
            parameters["phone"] = model.phoneWithoutZero
            parameters["country_code"] = model.countryCodeWithoutPlus
            parameters["email"] = model.email
            parameters["image"] = model.avatarId

            JsonStringService.printParametersAsJson(parameters: parameters, baseUrl: self.baseURL.absoluteString, path: self.path)

            return .requestParameters(parameters: parameters,
                                      encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return AppHeaders.appHeaders
    }
}
