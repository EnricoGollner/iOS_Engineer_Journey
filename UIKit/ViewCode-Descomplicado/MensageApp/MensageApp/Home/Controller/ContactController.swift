//
//  ContactController.swift
//  MensageApp
//
//  Created by Enrico Sousa Gollner on 12/12/23.
//

import UIKit
import FirebaseFirestore

protocol ContactProtocol: AnyObject {
    func alertStateError(title: String, message: String)
    func successContato()
}

class ContactController {
    weak var delegate: ContactProtocol?
    
    public func delegate(delegate: ContactProtocol?) {
        self.delegate = delegate
    }
    
    func addContact(idUser: String, email: String, emailUserLoged: String) {
        if email == emailUserLoged {
            self.delegate?.alertStateError(title: "You had added your own e-mail", message: "Add a new e-mail!")
            return
        }
        
        // check if user exist in firestore
        let firestore = Firestore.firestore()
        firestore.collection("users").whereField("email", isEqualTo: email).getDocuments { snapshot, error in
            //Save contact
            if let snapshot = snapshot {
                if snapshot.count == 0 {  // user with that e-mail was not found.
                    self.delegate?.alertStateError(title: "User is not registered", message: "Check the e-mail and try it again!")
                    return
                }
                
                for document in snapshot.documents {
                    let dados = document.data()
                    self.saveContact(dadosContato: dados, idUser: idUser)
                }
            } else {
                print(error?.localizedDescription ?? "Erro")
            }
        }
    }
    
    func saveContact(dadosContato: Dictionary<String, Any>, idUser: String) {
        let contact: Contact = Contact(dicionario: dadosContato)
        let firestore: Firestore = Firestore.firestore()
        
        firestore.collection("users").document(idUser).collection("contacts").document(contact.id ?? "").setData(dadosContato) { error in
            if error == nil {
                print("Success registering contact!")
                self.delegate?.successContato()
            }
        }
    }
}
