//
//  ChatView.swift
//  MensageApp
//
//  Created by Enrico Sousa Gollner on 16/12/23.
//

import AVFoundation
import UIKit

protocol ChatViewProtocol: AnyObject {
    func actionPushMessage()
}

class ChatView: UIView {
    weak private var delegate: ChatViewProtocol?
    
    public func delegate(delegate: ChatViewProtocol) {
        self.delegate = delegate
    }
    
    var bottomConstraint: NSLayoutConstraint?
    var player: AVAudioPlayer?
    
    lazy var navView: ChatNavigationView = {
        let view = ChatNavigationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var messageInputView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var messageBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = CustomColor.appLight
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = CustomColor.appPink
        button.layer.cornerRadius = 22.5
        button.layer.shadowColor = CustomColor.appLight.cgColor
        button.layer.shadowRadius = 10
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.shadowOpacity = 0.3
        button.addTarget(self, action: #selector(self.tappedSendMessage), for: .touchUpInside)
        button.setImage(UIImage(named: "send"), for: .normal)
        
        return button
    }()
    
    lazy var inputMessageTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.placeholder = "Digite aqui"
        textField.font = UIFont(name: CustomFont.poppinsSemiBold, size: 14)
        textField.textColor = .darkGray
        
        return textField
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        
        table.register(IncomingTextMessageTableViewCell.self, forCellReuseIdentifier: IncomingTextMessageTableViewCell.identifier)
        table.register(OutgoingTextMessageTableViewCell.self, forCellReuseIdentifier: OutgoingTextMessageTableViewCell.identifier)
        
        table.transform = CGAffineTransform(scaleX: 1, y: -1)
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.tableFooterView = UIView()
        
        return table
    }()
    
    public func configTableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource
    }
    
    public func configTextField(delegate: UITextFieldDelegate) {
        self.inputMessageTextField.delegate = delegate
    }
    
    public func reloadTableView() {
        self.tableView.reloadData()
    }
    
    public func configNavView(controller: ChatViewController) {
        self.navView.controller = controller
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.setUpVisualElements()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.inputMessageTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
        
        // we're basically setting a constraint as we do in configConstraints
        self.bottomConstraint = NSLayoutConstraint(item: self.messageInputView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        self.addConstraint(bottomConstraint ?? NSLayoutConstraint())
        
        self.sendButton.isEnabled = false
        self.sendButton.layer.opacity = 0.4
        self.sendButton.transform = .init(scaleX: 0.8, y: 0.8)
        self.inputMessageTextField.becomeFirstResponder()  // hide the keyboard
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpVisualElements() {
        self.addSubview(self.tableView)
        self.addSubview(self.navView)
        self.addSubview(self.messageInputView)
        self.messageInputView.addSubview(self.messageBar)
        self.messageBar.addSubview(self.sendButton)
        self.messageBar.addSubview(self.inputMessageTextField)
        
        self.configConstaints()
    }
    
    private func configConstaints() {
        NSLayoutConstraint.activate([
            self.navView.topAnchor.constraint(equalTo: self.topAnchor),
            self.navView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.navView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.navView.heightAnchor.constraint(equalToConstant: 140),
            
            self.tableView.topAnchor.constraint(equalTo: self.navView.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.messageInputView.topAnchor),
            
            self.messageInputView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.messageInputView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.messageInputView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.messageInputView.heightAnchor.constraint(equalToConstant: 80),
            
            self.messageBar.leadingAnchor.constraint(equalTo: self.messageInputView.leadingAnchor,constant: 20),
            self.messageBar.trailingAnchor.constraint(equalTo: self.messageInputView.trailingAnchor,constant: -20),
            self.messageBar.heightAnchor.constraint(equalToConstant: 55),
            self.messageBar.centerYAnchor.constraint(equalTo: self.messageInputView.centerYAnchor),
            
            self.sendButton.trailingAnchor.constraint(equalTo: self.messageBar.trailingAnchor, constant: -15),
            self.sendButton.heightAnchor.constraint(equalToConstant: 55),
            self.sendButton.widthAnchor.constraint(equalToConstant: 55),
            self.sendButton.bottomAnchor.constraint(equalTo: self.messageBar.bottomAnchor, constant: -10),
            
            self.inputMessageTextField.leadingAnchor.constraint(equalTo: self.messageBar.leadingAnchor,constant: 20),
            self.inputMessageTextField.trailingAnchor.constraint(equalTo: self.sendButton.leadingAnchor,constant: -5),
            self.inputMessageTextField.heightAnchor.constraint(equalToConstant: 45),
            self.inputMessageTextField.centerYAnchor.constraint(equalTo: self.messageBar.centerYAnchor)
        ])
    }
    
    @objc func handleKeyboardNotification(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            self.bottomConstraint?.constant = isKeyboardShowing ? -keyboardHeight : 0
            
            self.tableView.center.y = isKeyboardShowing ? self.tableView.center.y - keyboardHeight : self.tableView.center.y + keyboardHeight
            
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
                self.layoutIfNeeded()
            }) { completed in
                //Config when it's completed
            }
            
        }
    }
    
    @objc func tappedSendMessage() {
        self.sendButton.touchAnimations(s: self.sendButton)
        self.startPushMessage()
        self.delegate?.actionPushMessage()
        self.inputMessageTextField.text = ""
        self.playSound()
    }
    
    public func startPushMessage() {
        self.sendButton.isEnabled = false
        self.sendButton.layer.opacity = 0.4
        self.sendButton.transform = .init(scaleX: 0.8, y: 0.8)
    }
    
    public func playSound() {
        guard let url = Bundle.main.url(forResource: "send", withExtension: "wav") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            self.player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            
            guard let player = self.player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
}

extension ChatView: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        if self.inputMessageTextField.text == "" {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseInOut,  animations: {
                self.sendButton.isEnabled = false
                self.sendButton.layer.opacity = 0.4
                self.sendButton.transform = .init(scaleX: 0.8, y: 0.8)
            }, completion: { _ in
                // when the animation is completed
            })
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, animations: {
                self.sendButton.isEnabled = true
                self.sendButton.layer.opacity = 1
                self.sendButton.transform = .identity
            })
        }
    }
}
