//
//  HomeService.swift
//  APINetworkSecondProject
//
//  Created by Enrico Sousa Gollner on 28/10/23.
//

import Foundation

class HomeService {
    
    func getPeople(completion: @escaping (Result<People, NetworkError>) -> Void) {
        let url = "https://run.mocky.io/v3/4707d91f-e2fa-4ebc-ab4f-b0763ff80305"
        
        guard let url = URL(string: url) else {
            completion(.failure(.invalidUrl(url: url)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completion(.failure(.networkFailure(error)))
                return
            }
            
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let peopleList: People = try JSONDecoder().decode(People.self, from: data)
                completion(.success(peopleList))
                print("SUCCESS -> \(peopleList)")
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        task.resume()
    }
}
