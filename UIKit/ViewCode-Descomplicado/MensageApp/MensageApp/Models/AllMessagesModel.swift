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
    var nome: String?
    var lastMessage: String?
    var idDestinatario: String?
    
    init(dicionario: [String: Any]) {
        self.nome = dicionario["texto"] as? String
        self.lastMessage = dicionario["lastMessage"] as? String
        self.idDestinatario = dicionario["idDestinatario"] as? String
    }
}

class User {
    var nome: String?
    var email: String?
    
    init(dicionario: [String: Any]) {
        self.nome = dicionario["nome"] as? String
        self.email = dicionario["email"] as? String
    }
}

class Contact {
    var id: String?
    var nome: String?
    
    init(dicionario: [String: Any]?) {
        self.id = dicionario?["id"] as? String
        self.nome = dicionario?["nome"] as? String
    }
    
    convenience init(id: String?, nome: String?) {
        self.init(dicionario: nil)
        
        self.id = id
        self.nome = nome
    }
}
