//
//  HomeService.swift
//  APINetworkSecondProject
//
//  Created by Enrico Sousa Gollner on 28/10/23.
//

import Foundation

class HomeService {
    
    
    func getPeople(completion: @escaping (Result<[Person], NetworkError>) -> Void) {
        let urlString = "https://run.mocky.io/v3/4707d91f-e2fa-4ebc-ab4f-b0763ff80305"
        
        ServiceManager.shared.request(with: urlString, method: .get, decodeType: People.self) { result in
            switch (result) {
            case .success(let success):
                completion(.success(success.people))
            case .failure(let error):
                completion(.failure(.decodingError(error)))
            }
        }
        
    }
}
