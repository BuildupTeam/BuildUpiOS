//
//  MainWebService.swift
//  BuildUp
//
//  Created by Mohamed Khaled on 14/09/2023.
//

import Foundation
import Moya
import Alamofire

final class MainWebService {
    static var isRefreshingToken: Bool = false

    static func fetch(endPoint: TargetType, _ compltion: @escaping (Result<Any, NetworkError>, Int) -> Void) {
        
        let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: [.requestBody, .verbose])
        let provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(configuration: loggerConfig)])
        
        provider.request(MultiTarget(endPoint)) { (response) in
            switch response {
            case .success(let response):
                if response.statusCode >= 500 {
                    recordNonFetalError(response: response)
                    var networkError = NetworkError()
                    networkError.statusCode = response.statusCode
                    compltion(.failure(networkError), response.statusCode)
                } else if response.statusCode == 401 || response.statusCode == 403 {
                    if endPoint is RouteLoginApi {
                        do {
                            let jsonResponse = try response.mapJSON()
                            
                            compltion(Result.success(jsonResponse), response.statusCode)
                        } catch {
                            print(error.localizedDescription)
                        }
                    } else {
                        returnBaseResponse(response: response, compltion: compltion)
                    }
                    refreshAccessToken(endPoint: endPoint, compltion)
                    
                } else {
                    do {
                        let jsonResponse = try response.mapJSON()
                        compltion(Result.success(jsonResponse), response.statusCode)
                    } catch {
                        if response.statusCode >= 200 && response.statusCode < 300 {
                            returnBaseResponse(response: response, compltion: compltion)
                        }
                        
                        recordNonFetalError(response: response)
                        print(error.localizedDescription)
                    }
                }
                
            case .failure(let error):
                recordNonFetalError(error: error)
                compltion(.failure(NetworkError(error: error)), error.errorCode)
            }
        }
    }
    
    static func fetchCancellable<E: TargetType>(
        endPoint: E,
        _ compltion: @escaping (Result<Any, NetworkError>, Int) -> Void) -> Cancellable {
        let cancellableProvider = MoyaProvider<MultiTarget>(
            plugins: [NetworkLoggerPlugin()])
            .request(MultiTarget(endPoint)) { (response) in
                switch response {
                case .success(let response):
                    do {
                        let jsonResponse = try response.mapJSON()
                        compltion(Result.success(jsonResponse), response.statusCode)
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                case .failure(let error):
                    compltion(.failure(NetworkError(error: error)), error.errorCode)
                }
            }
        
        return cancellableProvider
    }
}

// MARK: - Handle Refresh Token
 extension MainWebService {
    static func refreshAccessToken(endPoint: TargetType, _ compltion: @escaping (Result<Any, NetworkError>, Int) -> Void) {
        let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: [.requestBody, .verbose])
        guard let refreshToken = CachingService.getUser()?.refreshToken else { return }
        let refreshTokenEndPoint = RouteAccessTokenApi.refreshToken(refreshToken: refreshToken)

        if MainWebService.isRefreshingToken {
            self.fetch(endPoint: endPoint, compltion)
        } else {
            MainWebService.isRefreshingToken = true
            MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(configuration: loggerConfig)]).request(MultiTarget(refreshTokenEndPoint)) { (response) in

                switch response {
                case .success(let response):
                    if response.statusCode >= 200 && response.statusCode < 300 {
                        do {
                            let jsonResponse = try response.mapJSON() as? [String: Any]

                            let data = jsonResponse?["data"] as? [String: Any]
                            let refreshToken = data?["refresh_token"] as? String
                            let accessToken = data?["access_token"] as? String

                            if let userModel = CachingService.getUser() {
                                userModel.refreshToken = refreshToken
                                userModel.accessToken = accessToken
                                CachingService.setUser(userModel)
                                MainWebService.isRefreshingToken = false

                                self.fetch(endPoint: endPoint, compltion)
                            }
                        } catch {
                            MainWebService.isRefreshingToken = false
                            print(error.localizedDescription)
                        }
                    } else {
                        MainWebService.isRefreshingToken = false
                        print(response.statusCode)
                        LauncherViewController.logoutToLoginView()
                    }
                case .failure(let error):
                    MainWebService.isRefreshingToken = false
                    compltion(.failure(NetworkError(error: error)), error.errorCode)
                }
            }
        }
    }
 }

extension MainWebService {
    static func returnBaseResponse(
        response: Response,
        compltion: @escaping (Result<Any, NetworkError>, Int) -> Void) {
        let baseJsonResponse = "{\"data\":{\"message\":\"Success\" }}"
        
        if let data: Data = baseJsonResponse.data(using: .utf8) {
            let successResponse = Response(statusCode: response.statusCode, data: data)
            
            do {
                let jsonResponse = try successResponse.mapJSON()
                
                compltion(Result.success(jsonResponse), response.statusCode)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension MainWebService {
    static func recordNonFetalError(response: Response) {
        let info = [
            "phone": CachingService.getUser()?.customer?.phone ?? "",
          "url": response.request?.url?.absoluteString ?? ""
        ]

        let error = NSError(
            domain: response.request?.url?.absoluteString ?? "",
            code: response.statusCode,
            userInfo: info)
        
//        Crashlytics.crashlytics().record(error: error)
    }
    
    static func recordNonFetalError(error: MoyaError) {
        let info = [
            "phone": CachingService.getUser()?.customer?.phone ?? "",
            "url": error.response?.request?.url?.absoluteString ?? ""
        ]

        let errorObject = NSError(
            domain: error.response?.request?.url?.absoluteString ?? "",
            code: error.errorCode,
            userInfo: info)
        
//        Crashlytics.crashlytics().record(error: errorObject)
    }
}
