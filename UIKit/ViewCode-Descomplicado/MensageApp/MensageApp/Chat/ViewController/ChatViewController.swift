//
//  ChatViewController.swift
//  MensageApp
//
//  Created by Enrico Sousa Gollner on 16/12/23.
//

import UIKit

class ChatViewController: UIViewController {
    
    var listaMensagens: [Message] = []
    
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
