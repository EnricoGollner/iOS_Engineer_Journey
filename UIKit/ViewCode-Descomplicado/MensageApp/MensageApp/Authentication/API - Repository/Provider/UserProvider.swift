//
//  UserProvider.swift
//  MensageApp
//
//  Created by Enrico Sousa Gollner on 04/12/23.
//

import Foundation
import FirebaseAuth

protocol UserProviderProtocol {
    func login(parameters: [AnyHashable: Any], completionHandler: @escaping (Result<UserLogin, Error>) -> Void)
    func register(parameters: [AnyHashable: Any], completionHandler: @escaping (Result<UserLogin, Error>) -> Void)
}

//Comunicates with API or local readings (MOCK, Core Data)
class UserProvider: UserProviderProtocol {
    lazy var auth = Auth.auth()
    
    func login(parameters: [AnyHashable: Any], completionHandler: @escaping (Result<UserLogin, Error>) -> Void) {
        let body: NSDictionary = parameters[Constants.ParametersKeys.body] as! NSDictionary
        let UserLogin = body[Constants.ParametersKeys.userLogin] as! UserLogin
        
        self.auth.signIn(withEmail: UserLogin.email, password: UserLogin.password) { result, error in
            if let error = error {
                completionHandler(.failure(error))
            } else {
                completionHandler(.success(UserLogin))
            }
        }
    }
    
    func register(parameters: [AnyHashable : Any], completionHandler: @escaping (Result<UserLogin, Error>) -> Void) {
        let body: NSDictionary = parameters[Constants.ParametersKeys.body] as! NSDictionary
        let UserLogin = body[Constants.ParametersKeys.userLogin] as! UserLogin
        
        self.auth.createUser(withEmail: UserLogin.email, password: UserLogin.password) { (result, error) in
            if let error = error {
                completionHandler(.failure(error))
            } else {
                UserLogin.idUser = result?.user.uid
                completionHandler(.success(UserLogin))
            }
        }
    }
    
}
