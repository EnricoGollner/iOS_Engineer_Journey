//
//  MessageAllModel.swift
//  MensageApp
//
//  Created by Enrico Sousa Gollner on 11/12/23.
//

import Foundation

class Message {
    var text: String?
    var idUser: String?
    
    init(dicionario: [String: Any]) {
        self.text = dicionario["texto"] as? String
        self.idUser = dicionario["idUser"] as? String
    }
}

class Conversation {
    var name: String?
    var lastMessage: String?
    var idDestinatario: String?
    
    init(dicionario: [String: Any]) {
        self.idDestinatario = dicionario["idDestinatario"] as? String
        self.name = dicionario["texto"] as? String
        self.lastMessage = dicionario["lastMessage"] as? String
        
    }
}

class User {
    var name: String?
    var email: String?
    
    init(dicionario: [String: Any]) {
        self.name = dicionario["name"] as? String
        self.email = dicionario["email"] as? String
    }
}

class Contact {
    var id: String?
    var name: String?
    
    init(dicionario: [String: Any]?) {
        self.id = dicionario?["id"] as? String
        self.name = dicionario?["name"] as? String
    }
    
    convenience init(id: String?, name: String?) {
        self.init(dicionario: nil)
        
        self.id = id
        self.name = name
    }
}
