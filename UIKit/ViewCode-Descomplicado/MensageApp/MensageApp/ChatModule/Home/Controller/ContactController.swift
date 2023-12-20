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
    
    private let firestore: Firestore = Firestore.firestore()
    
    func addContact(idUser: String, email: String, emailUserLoged: String) {
        if email == emailUserLoged {
            self.delegate?.alertStateError(title: "Add a new e-mail!", message: "You had added your own e-mail")
            return
        }
        
        // check if user exist in firestore
        firestore.collection("users").whereField("email", isEqualTo: email).getDocuments { snapshot, error in
            //Save contact
            if let snapshot {
                if snapshot.count == 0 {  // user with that e-mail was not found.
                    self.delegate?.alertStateError(title: "User not found", message: "Check the e-mail and try again!")
                    return
                }
                
                for document in snapshot.documents {
                    let dados = document.data()
                    self.saveContact(idUser: idUser, dadosContato: dados)
                }
            } else {
                print(error?.localizedDescription ?? "Erro")
            }
        }
    }
    
    func saveContact(idUser: String, dadosContato: Dictionary<String, Any>) {
        let contact: Contact = Contact(dicionario: dadosContato)
        
        firestore.collection("users").document(idUser).collection("contacts").document(contact.id ?? "").setData(dadosContato) { error in
            if error == nil {
                print("Success registering contact!")
                self.delegate?.successContato()
            }
        }
    }
}
