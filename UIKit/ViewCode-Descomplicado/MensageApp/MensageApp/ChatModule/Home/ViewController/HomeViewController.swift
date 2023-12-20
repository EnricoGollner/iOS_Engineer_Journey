//
//  ViewController.swift
//  MensageApp
//
//  Created by Enrico Sousa Gollner on 04/12/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestoreInternal

class HomeViewController: UIViewController {
    
    var auth: Auth?
    var db: Firestore?
    var idUserLogged: String?
    
    var screenIsContact: Bool?
    var emailUsuarioLogado: String?
    var alert: Alert?
    
    var contact: ContactController?
    var contactList: [Contact] = []
    var conversationsList: [Conversation] = []
    var conversationsListener: ListenerRegistration?
    
    
    lazy var homeView: HomeView = {
        let homeView = HomeView(frame: .zero)
        return homeView
    }()
    
    override func loadView() {
        self.view = self.homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboardOnTouch()
        
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = CustomColor.appLight
        
        self.configHomeView()
        self.configCollectionView()
        self.configAlert()
        self.configIdentifierFirebase()
        self.configContactController()
        self.addListenerConversations()
    }
    
    private func configHomeView() {
        self.homeView.navView.delegate(delegate: self)
    }
    
    private func configCollectionView() {
        self.homeView.delegateCollectionView(delegate: self, dataSource: self)
    }
    
    private func configAlert() {
        self.alert = Alert(controller: self)
    }
    
    private func configIdentifierFirebase() {
        self.auth = Auth.auth()
        self.db = Firestore.firestore()
        
        // User id logged
        if let currentUser = auth?.currentUser {
            self.idUserLogged = currentUser.uid
            self.emailUsuarioLogado = currentUser.email
        }
    }
    
    private func configContactController() {
        self.contact = ContactController()
        self.contact?.delegate(delegate: self)
    }
    
    private func addListenerConversations() {
        if let idUserLogged = auth?.currentUser?.uid {
            self.conversationsListener = db?.collection("conversations").document(idUserLogged).collection("lastConversations").addSnapshotListener({ querySnapshot, error in
                
                if let error {
                    self.alert?.getAlert(title: "Error in listenner", message: error.localizedDescription)
                    return
                } else if let querySnapshot {
                    self.conversationsList.removeAll()
                    
                    for document in querySnapshot.documents {
                        let data = document.data()
                        self.conversationsList.append(Conversation(dicionario: data))
                    }
                    self.homeView.reloadCollectionView()
                }
            })
        }
    }
    
    private func getContacts() {
        self.contactList.removeAll()
        
        self.db?.collection("users").document(self.idUserLogged ?? "").collection("contacts").getDocuments(completion: { snapshot, error in
            if let error {
                self.alert?.getAlert(title: "Error searching contacts", message: error.localizedDescription)
                return
            }
            
            if let snapshot {
                for document in snapshot.documents {
                    let contactData = document.data()
                    self.contactList.append(Contact(dicionario: contactData))
                }
            }
            
            self.homeView.reloadCollectionView()
        })
    }
}

extension HomeViewController: ContactProtocol {
    func alertStateError(title: String, message: String) {
        self.alert?.getAlert(title: title, message: message)
    }
    
    func successContato() {
        self.alert?.getAlert(title: "Registered!", message: "User's registered successfuly!", completion: {
            self.getContacts();
        })
    }
    
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.screenIsContact ?? false {
            return self.contactList.count + 1
        }
        
        return self.contactList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if self.screenIsContact ?? false {
            if indexPath.row == self.contactList.count {
                let addContactCell = collectionView.dequeueReusableCell(withReuseIdentifier: LastMessageCollectionViewCell.identifier, for: indexPath)
                return addContactCell
            } else {
                let contactCell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageDetailCollectionViewCell.identifier, for: indexPath) as? MessageDetailCollectionViewCell
                contactCell?.setUpViewContact(contact: self.contactList[indexPath.row])
                return contactCell ?? UICollectionViewCell()
            }
        }
    
        // Messages cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageDetailCollectionViewCell.identifier, for: indexPath) as? MessageDetailCollectionViewCell
        cell?.setUpViewConversation(conversation: self.conversationsList[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.screenIsContact ?? false {
            if indexPath.row == self.contactList.count {
                self.alert?.addContactAlert(completion: { emailUserToAdd in
                    self.contact?.addContact(idUser: self.idUserLogged ?? "", email: emailUserToAdd, emailUserLoged: self.emailUsuarioLogado ?? "")
                })
            } else {
                let vc: ChatViewController = ChatViewController()
                vc.contact = self.contactList[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            let vc: ChatViewController = ChatViewController()
            let data = self.conversationsList[indexPath.row]
            let contact = Contact(id: data.idRecepient ?? "", name: data.name ?? "")
            vc.contact = contact
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}

extension HomeViewController: NavViewProtocol {
    func typeSectionAccessing(type: TypeSectionAccessing) {
        switch type {
        case .contact:
            self.screenIsContact = true
            self.getContacts()
            self.conversationsListener?.remove()
        case .conversation:
            self.screenIsContact = false
            self.addListenerConversations()
            self.homeView.reloadCollectionView()
        }
    }
}



