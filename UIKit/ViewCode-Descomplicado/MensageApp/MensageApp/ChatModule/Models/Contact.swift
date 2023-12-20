//
//  Contact.swift
//  MensageApp
//
//  Created by Enrico Sousa Gollner on 11/12/23.
//

import Foundation

class Contact {
    var id: String?
    var name: String?
    
    init(dicionario: [String: Any]?) {
        self.id = dicionario?["idUser"] as? String
        self.name = dicionario?["name"] as? String
    }
    
    convenience init(id: String?, name: String?) {
        self.init(dicionario: nil)
        
        self.id = id
        self.name = name
    }
}
