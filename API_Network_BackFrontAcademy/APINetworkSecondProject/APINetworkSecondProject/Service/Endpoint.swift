//
//  Endpoint.swift
//  APINetworkSecondProject
//
//  Created by Enrico Sousa Gollner on 12/11/23.
//

import Foundation

///Endpoint model to request
struct Endpoint {
    let url: String
    let httpMethod: HTTPMethod
    let headers: [String: String]?
    let parameters: Parameters?
}


enum Parameters {
    case dictionary([String: Any])
    case encodable(Encodable)
}
