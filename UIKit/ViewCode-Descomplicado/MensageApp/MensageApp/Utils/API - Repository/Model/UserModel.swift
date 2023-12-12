//
//  UserModel.swift
//  MensageApp
//
//  Created by Enrico Sousa Gollner on 04/12/23.
//

import Foundation

class UserModel {
    var userId: String?
    let email: String
    let password: String
    
    init() {  // Empty constructor
        self.userId = nil
        self.email = ""
        self.password = ""
    }
    
    init(userId: String? = nil, email: String, password: String) {
        self.userId = userId
        self.email = email
        self.password = password
    }
}
