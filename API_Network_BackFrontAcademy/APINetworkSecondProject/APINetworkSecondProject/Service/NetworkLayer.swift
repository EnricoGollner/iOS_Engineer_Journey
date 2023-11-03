//
//  NetworkLayer.swift
//  APINetworkSecondProject
//
//  Created by Enrico Sousa Gollner on 03/11/23.
//

import Foundation

protocol NetworkLayer {
    func request<T: Decodable>(with urlString: String, method: HTTPMethod, decodedType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void)
}
