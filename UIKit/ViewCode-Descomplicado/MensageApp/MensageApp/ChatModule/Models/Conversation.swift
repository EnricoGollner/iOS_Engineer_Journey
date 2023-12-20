//
//  Conversation.swift
//  MensageApp
//
//  Created by Enrico Sousa Gollner on 19/12/23.
//

import Foundation

class Conversation {
    var idRecepient: String?
    var name: String?
    var lastMessage: String?
    
    init(dicionario: [String: Any]) {
        self.idRecepient = dicionario["idRecepient"] as? String
        self.name = dicionario["name"] as? String
        self.lastMessage = dicionario["lastMessage"] as? String
        
    }
}
