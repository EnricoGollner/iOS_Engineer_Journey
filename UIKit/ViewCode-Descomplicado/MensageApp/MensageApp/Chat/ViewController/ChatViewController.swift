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
    
    var listaMensagens: [Message] = []
    var idUserLogged: String?
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
    
    override func loadView() {
        self.view = self.chatView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        chatView.configNavView(controller: self)
    }
    
    @objc public func tappedBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
