//
//  ServiceManager.swift
//  APINetworkSecondProject
//
//  Created by Enrico Sousa Gollner on 30/10/23.
//

import Foundation

class ServiceManager: NetworkLayer {
    
    static var shared: ServiceManager = ServiceManager()  // Singlaton
    
    private var baseURL: String
    
    init(baseURL: String? = nil) {
        if let baseURL {
            self.baseURL = baseURL
        } else if let baseURLString = Bundle.main.infoDictionary?["BaseURL"] as? String {
            self.baseURL = baseURLString
        } else {
            self.baseURL = ""
        }
    }
    
    var session: URLSession = URLSession.shared
    
    func request<T>(with urlString: String, method: HTTPMethod = .get, decodedType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        guard let url: URL = URL(string: urlString) else {
            completion(.failure(.invalidUrl(url: urlString)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error {
                    completion(.failure(.networkFailure(error)))
                    return
                }
                
                guard let data else {
                    completion(.failure(.noData))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let object: T = try decoder.decode(T.self, from: data)
                    completion(.success(object))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
        task.resume()
    }
    
    
}
