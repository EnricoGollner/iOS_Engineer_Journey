//
//  UserManager.swift
//  MensageApp
//
//  Created by Enrico Sousa Gollner on 04/12/23.
//

import Foundation

protocol UserManagerProtocol {
    func register(email: String, password: String,
                  successHandler: @escaping (UserLogin) -> Void,
                  failureHandler: @escaping (Error) -> Void)
    
    func login(email: String, password: String,
                  successHandler: @escaping (UserLogin) -> Void,
                  failureHandler: @escaping (Error) -> Void)
}

// Comunicates with Business layer (manage the informations we're sending or receiving from the API or local...)
class UserManager: UserManagerProtocol {
    let business: UserBusinessProtocol
    
    init(business: UserBusinessProtocol) {
        self.business = business
    }
    
    func login(email: String, password: String,
               successHandler: @escaping (UserLogin) -> Void,
               failureHandler: @escaping (Error) -> Void) {
        business.login(email: email, password: password) { result in
            switch result {
            case .success(let userModel):
                successHandler(userModel)
            case .failure(let error):
                failureHandler(error)
            }
        }
    }
    
    func register(email: String, password: String, successHandler: @escaping (UserLogin) -> Void,
                  failureHandler: @escaping (Error) -> Void) {
        business.register(email: email, password: password) { result in
            switch result {
            case .success(let userModel):
                successHandler(userModel)
            case .failure(let error):
                failureHandler(error)
            }
        }
    }
    
}
