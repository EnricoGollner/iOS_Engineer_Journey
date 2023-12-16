//
//  ChatViewController.swift
//  MensageApp
//
//  Created by Enrico Sousa Gollner on 16/12/23.
//

import UIKit

class ChatViewController: UIViewController {
    
    lazy var chatView: ChatView = {
        return ChatView(frame: .zero)
    }()
    
    override func loadView() {
        self.view = self.chatView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc public func tappedBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
