//
//  ChatViewController.swift
//  MensageApp
//
//  Created by Enrico Sousa Gollner on 16/12/23.
//

import AVFoundation
import FirebaseAuth
import FirebaseFirestore
import UIKit

class ChatViewController: UIViewController {
    
    var messagesList: [Message] = []
    var idLoggedUser: String?
    var contact: Contact?
    var auth: Auth?
    var messageListener: ListenerRegistration?
    var db: Firestore?
    var contactName: String?
    var userNameLogged: String?
    
    lazy var chatView: ChatView = {
        let chatView = ChatView(frame: .zero)
        return chatView
    }()
    
    //MARK: - Life cycles
    override func viewWillAppear(_ animated: Bool) {
        self.addListennerRestoreMessages()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.messageListener?.remove()
    }
    
    override func loadView() {
        self.view = self.chatView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.chatView.configNavView(controller: self)
        self.configDataFirestore()
        self.configChatView()
        self.dismissKeyboardOnTouch()
    }
    
    private func configDataFirestore() {
        self.auth = Auth.auth()
        self.db = Firestore.firestore()
        
        if let id = self.auth?.currentUser?.uid {
            self.idLoggedUser = id
            self.restoreUserLoggedData()
        }
        
        if let name = self.contact?.name {
            self.contactName = name
            
        }
    }
    
    public func addListennerRestoreMessages() {
        if let idRecepient = self.contact?.id {
            self.messageListener = db?.collection("messages").document(self.idLoggedUser ?? "").collection(idRecepient).order(by: "date", descending: true).addSnapshotListener({ querySnapshot, error in
                // clear all the messeges
                self.messagesList.removeAll()
                
                if let querySnapshot {
                    for document in querySnapshot.documents {
                        let data = document.data()
                        self.messagesList.append(Message(dicionario: data))
                    }
                    self.chatView.reloadTableView()
                }
            })
        }
    }
    
    private func restoreUserLoggedData() {
        let users = self.db?.collection("users").document(self.idLoggedUser ?? "")
        
        users?.getDocument(completion: { documentSnapshot, error in
            if let error {
                Alert(controller: self).getAlert(title: "Error", message: error.localizedDescription)
                return
            }
            
            let userData: Contact = Contact(dicionario: documentSnapshot?.data() ?? [:])
            self.userNameLogged = userData.name
        })
    }
    
    private func configChatView() {
        self.chatView.delegate(delegate: self)
        self.chatView.configNavView(controller: self)
        self.chatView.configTableView(delegate: self, dataSource: self)
    }
    
    @objc public func tappedBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func sendMessage(idSender: String, idRecipient: String, message: [String: Any]) {
        self.db?.collection("messages").document(idSender).collection(idRecipient).addDocument(data: message)
    }
    
    private func saveConversation(idSender: String, idRecepient: String, conversation: [String: Any]) {
        self.db?.collection("conversations").document(idSender).collection("lastConversations").document(idRecepient).setData(conversation)
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messagesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = self.messagesList[indexPath.row]
        let idUser = data.idUser ?? ""
        
        if self.idLoggedUser != idUser {
            // Left side - receiving message
            let cell = tableView.dequeueReusableCell(withIdentifier: IncomingTextMessageTableViewCell.identifier, for: indexPath) as? IncomingTextMessageTableViewCell
            cell?.transform = CGAffineTransform(scaleX: 1, y: -1)
            cell?.setUpCell(message: data)
            cell?.selectionStyle = .none
            
            return cell ?? UITableViewCell()
        }
        
        //Right side - sending message
        let cell = tableView.dequeueReusableCell(withIdentifier: OutgoingTextMessageTableViewCell.identifier, for: indexPath) as? OutgoingTextMessageTableViewCell
        cell?.transform = CGAffineTransform(scaleX: 1, y: -1)
        cell?.setUpCell(message: data)
        cell?.selectionStyle = .none
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let description: String = self.messagesList[indexPath.row].message ?? ""
        
        let font = UIFont(name: CustomFont.poppinsSemiBold, size: 14)
        
        let estimateHeight = description.heightWithConstrainedWidth(width: 220, font: font ?? UIFont())
        
        return CGFloat(65 + estimateHeight)  // 65 is the sum of spacing we setted as constraints of the cell
    }
}

extension ChatViewController: ChatViewProtocol {
    func actionPushMessage() {
        let message: String = self.chatView.inputMessageTextField.text ?? ""
        
        
        if let idRecipientUser = self.contact?.id {
            let messageJson: Dictionary<String, Any> = [
                "idUser": self.idLoggedUser ?? "",
                "message": message,
                "date": FieldValue.serverTimestamp()
            ]
            
            // Saving message TO RECEPIENT FROM SENDER
            self.sendMessage(idSender: self.idLoggedUser ?? "", idRecipient: idRecipientUser, message: messageJson)
            
            // Saving message TO SENDER FROM RECEPIENT
            self.sendMessage(idSender: idRecipientUser, idRecipient: self.idLoggedUser ?? "", message: messageJson)
            
            var conversation: [String: Any] = ["lastMessage": message]
            
            // Saving conversation to recepient (data of who's receiving)
            conversation["idSender"] = idLoggedUser ?? ""
            conversation["idRecepient"] = idRecipientUser
            conversation["name"] = self.contactName ?? ""
            
            self.saveConversation(idSender: idLoggedUser ?? "", idRecepient: idRecipientUser, conversation: conversation)
            
            // Saving talk to sender (data of who's sending)
            conversation["idSender"] = idRecipientUser
            conversation["idRecepient"] = idLoggedUser ?? ""
            conversation["name"] = self.userNameLogged ?? ""
            
            self.saveConversation(idSender: idRecipientUser, idRecepient: idLoggedUser ?? "", conversation: conversation)
        }
    }
}
