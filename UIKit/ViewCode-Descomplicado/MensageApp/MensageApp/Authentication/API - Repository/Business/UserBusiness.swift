//
//  UserBusiness.swift
//  MensageApp
//
//  Created by Enrico Sousa Gollner on 04/12/23.
//

import Foundation

protocol UserBusinessProtocol {
    func register(email: String, password: String, completionHandler: @escaping (Result<UserLogin, Error>) -> Void )
    func login(email: String, password: String, completionHandler: @escaping (Result<UserLogin, Error>) -> Void)
}

// Business layer Comunicates with Provider layer (making decisions, manipulating what we need)
class UserBusiness: UserBusinessProtocol {
    let provider: UserProvider = UserProvider()
    
    func login(email: String, password: String, completionHandler: @escaping (Result<UserLogin, Error>) -> Void) {
        provider.login(parameters: getParams(email, password)) { result in
            switch result {
            case .success(let UserLogin):
                completionHandler(.success(UserLogin))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func register(email: String, password: String, completionHandler: @escaping (Result<UserLogin, Error>) -> Void) {
        provider.register(parameters: getParams(email, password)) { result in
            switch result {
            case .success(let UserLogin):
                completionHandler(.success(UserLogin))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    private func getParams(_ email: String, _ password: String) -> [AnyHashable: Any] {
        
        let UserLogin = UserLogin(userId: nil, email: email, password: password)
        let params: [AnyHashable: Any] = [Constants.ParametersKeys.body: [Constants.ParametersKeys.userLogin: UserLogin]]
        
        return params
    }
}

