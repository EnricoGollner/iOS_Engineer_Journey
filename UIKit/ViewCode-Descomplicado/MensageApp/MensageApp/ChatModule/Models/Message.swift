//
//  Message.swift
//  MensageApp
//
//  Created by Enrico Sousa Gollner on 19/12/23.
//

import Foundation

class Message {
    var idUser: String?
    var message: String?
    
    init(dicionario: [String: Any]) {
        self.idUser = dicionario["idUser"] as? String
        self.message = dicionario["message"] as? String
    }
}
