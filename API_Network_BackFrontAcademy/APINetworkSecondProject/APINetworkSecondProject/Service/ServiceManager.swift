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
    private var requestBuilder: RequestBuilder
    private var session: URLSession
    private var decoder: JSONDecoder
    
    init(session: URLSession = URLSession.shared, baseURL: String? = nil, requestBuilder: RequestBuilder = DefaultRequestBuilder(), decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        
        if let baseURL {
            self.baseURL = baseURL
        } else if let baseURLString = Bundle.main.infoDictionary?["BaseURL"] as? String {  // Search in info.plist the value with the key "BaseURL"
            self.baseURL = baseURLString
        } else {
            self.baseURL = ""
        }
        
        self.requestBuilder = requestBuilder
        self.decoder = decoder
    }
    
    func request<T>(with endpoint: Endpoint, decodeType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        
        let urlString = baseURL + endpoint.url
        
        guard let url = URL(string: urlString) else {
            NetworkLogger.logError(error: .invalidUrl(url: urlString))
            completion(.failure(.invalidUrl(url: urlString)))
            return
        }
        
        let urlRequest = requestBuilder.buildRequest(with: endpoint, url: url)
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            NetworkLogger.log(urlRequest: urlRequest, response: response, data: data, error: error)
            
            DispatchQueue.main.async {
                if let error {
                    completion(.failure(.networkFailure(error)))
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
                    self.decoder.dateDecodingStrategy = .iso8601
                    let object: T = try self.decoder.decode(T.self, from: data)
                    completion(.success(object))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
        task.resume()
    }
    
    
}
