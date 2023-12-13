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
        self.dismissKeyboard()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = CustomColor.appLight
        self.configHomeView()
        self.configCollectionView()
        self.configAlert()
        self.configIdentifierFirebase()
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
    
    private func configContact() {
        self.contact = ContactController()
        self.contact?.delegate(delegate: self)
    }
    
    private func addListenerConversations() {
        if let idUserLogged = auth?.currentUser?.uid {
            self.conversationsListener = db?.collection("conversations").document(idUserLogged).collection("last_conversations").addSnapshotListener({ querySnapshot, error in
                
                if let error {
                    self.alert?.getAlert(title: "Error in listenner", message: error.localizedDescription)
                    return
                }
                self.conversationsList.removeAll()
                if let snapshot = querySnapshot {
                    for document in snapshot.documents {
                        let data = document.data()
                        self.conversationsList.append(Conversation(dicionario: data))
                        self.homeView.reloadCollectionView()
                    }
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
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
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



