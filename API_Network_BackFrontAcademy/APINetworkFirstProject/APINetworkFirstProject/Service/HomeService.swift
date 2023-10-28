//
//  HomeService.swift
//  APINetworkFirstProject
//
//  Created by Enrico Sousa Gollner on 28/10/23.
//

import Foundation

class HomeService {
    
    func getPeopleList(completion: @escaping (Result<PeopleList, NetworkError>) -> Void) {
        let urlString = "https://run.mocky.io/v3/4707d91f-e2fa-4ebc-ab4f-b0763ff80305"
        
        //Check if the URL is correct:
        guard let url: URL = URL(string: urlString) else {
            completion(.failure(.invalidUrl(url: urlString)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                print("ERROR \(#function) - Detalhe do erro: \(error.localizedDescription)")
                completion(.failure(.networkFailure(error)))
                return
            }
            
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            // Check if response is valid with statusCode == 200
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            // Decoding response
            do {
                let peopleList: PeopleList = try JSONDecoder().decode(PeopleList.self, from: data)
                print("SUCCESS -> \(#function)")
                completion(.success(peopleList))
            } catch {
                print("ERROR -> \(#function) \(error.localizedDescription)")
                completion(.failure(.decodingError(error)))
            }
            
            
        }
        
        task.resume()
    }
    
}
