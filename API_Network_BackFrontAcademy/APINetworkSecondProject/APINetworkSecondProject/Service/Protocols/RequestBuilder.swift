//
//  RequestBuilder.swift
//  APINetworkSecondProject
//
//  Created by Enrico Sousa Gollner on 12/11/23.
//

import Foundation

protocol RequestBuilder {
    func buildRequest(with endpoint: Endpoint, url: URL) -> URLRequest
}

