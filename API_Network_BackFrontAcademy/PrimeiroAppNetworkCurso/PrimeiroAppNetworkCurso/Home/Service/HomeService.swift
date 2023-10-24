//
//  HomeService.swift
//  PrimeiroAppNetworkCurso
//
//  Created by Enrico Sousa Gollner on 23/10/23.
//

import UIKit

class HomeService: NSObject {
    
    func getPersonList(completion: @escaping (Result<PeopleList, NetworkError>) -> Void) {
        let urlString: String = "https://run.mocky.io/v3/4707d91f-e2fa-4ebc-ab4f-b0763ff80305"
        
        guard let url: URL = URL(string: urlString) else {  // String to URL
            completion(.failure(.invalidUrl(url: urlString)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error {  // error = error
                print("ERROR \(#function) - Detalhe do erro: \(error.localizedDescription)")
                completion(.failure(.networkFailure(error)))
                return
            }
            
            guard let data else {  // data = data
                completion(.failure(.noData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
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
