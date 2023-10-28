//
//  NetworkError.swift
//  APINetworkFirstProject
//
//  Created by Enrico Sousa Gollner on 28/10/23.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl(url: String)
    case noData
    case invalidResponse
    case decodingError(Error)
    case networkFailure(Error)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidUrl(let url):
            return "Invalid URL: \(url)"
        case .noData:
            return "Error receiving data from API."
        case .invalidResponse:
            return "Invalid response from API."
        case .decodingError(let error):
            return "Decoding failed: \(error.localizedDescription)"
        case .networkFailure(let error):
            return "Network failed: \(error.localizedDescription)"
        }
    }
}
