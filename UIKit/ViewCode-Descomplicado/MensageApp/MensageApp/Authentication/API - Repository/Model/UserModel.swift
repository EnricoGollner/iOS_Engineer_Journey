//
//  UserModel.swift
//  MensageApp
//
//  Created by Enrico Sousa Gollner on 04/12/23.
//

import Foundation

class UserLogin {
    var idUser: String?
    let email: String
    let password: String
    
    init() {  // Empty constructor
        self.idUser = nil
        self.email = ""
        self.password = ""
    }
    
    init(userId: String? = nil, email: String, password: String) {
        self.idUser = userId
        self.email = email
        self.password = password
    }
}
