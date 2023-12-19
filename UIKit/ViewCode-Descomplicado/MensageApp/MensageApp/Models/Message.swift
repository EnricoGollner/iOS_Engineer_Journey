//
//  Message.swift
//  MensageApp
//
//  Created by Enrico Sousa Gollner on 19/12/23.
//

import Foundation

class Message {
    var text: String?
    var idUser: String?
    
    init(dicionario: [String: Any]) {
        self.text = dicionario["message"] as? String
        self.idUser = dicionario["idUser"] as? String
    }
}
