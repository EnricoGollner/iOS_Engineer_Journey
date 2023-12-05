//
//  DefaultRequestBuilder.swift
//  APINetworkSecondProject
//
//  Created by Enrico Sousa Gollner on 12/11/23.
//

import Foundation

/// Create the URLRequest we need to make the request (ALLOWS Headers and Parameters)
class DefaultRequestBuilder: RequestBuilder {
    func buildRequest(with endpoint: Endpoint, url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = endpoint.headers
        
        ///Adding parameters to request if they are defined in the `Endpoint` model
        if let parameters = endpoint.parameters {
            switch (parameters) {
            case .dictionary(let dictionary):
                urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: dictionary, options: .fragmentsAllowed)
            case .encodable(let encodable):
                urlRequest.httpBody = try? JSONEncoder().encode(encodable)
            }
        }
        
        return urlRequest
    }
}

/// Create the URLRequest we need to make the request (No parameter)
class NoParametersRequestBuilder: RequestBuilder {
    func buildRequest(with endpoint: Endpoint, url: URL) -> URLRequest {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = endpoint.headers
        
        return urlRequest
    }
}
