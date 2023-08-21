//
//  NetworkCachePolicy.swift
//  flyers
//
//  Created by Mahmoud Nasser on 27/09/2022.
//

import Foundation
import Moya

protocol CachePolicyGettableType {
    var cachePolicy: URLRequest.CachePolicy? { get }
}

final class CachePolicyPlugin: PluginType {
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard let policyGettable = target as? CachePolicyGettableType, let policy = policyGettable.cachePolicy else {
            return request
        }

        var mutableRequest = request
        mutableRequest.cachePolicy = policy

        return mutableRequest
    }
}

extension MultiTarget: CachePolicyGettableType {
    var cachePolicy: URLRequest.CachePolicy? {
        guard let policyTarget = target as? CachePolicyGettableType else {
            return nil
        }
        
        return policyTarget.cachePolicy
    }
}
