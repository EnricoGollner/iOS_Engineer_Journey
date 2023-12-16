//
//  MessageDetailCollectionViewCell.swift
//  MensageApp
//
//  Created by Enrico Sousa Gollner on 12/12/23.
//

import UIKit

class MessageDetailCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: MessageDetailCollectionViewCell.self)
    
    lazy var imageView: UIImageView = {
        let imgView: UIImageView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 26
        imgView.image = UIImage(named: "imagem-perfil")
        
        return imgView
    }()
    
    lazy var userNameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUpVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpVisualElements() {
        self.addSubview(imageView)
        self.addSubview(userNameLabel)
        
        self.configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            self.imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.imageView.widthAnchor.constraint(equalToConstant: 55),
            self.imageView.heightAnchor.constraint(equalToConstant: 55),
            
            
            self.userNameLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 15),
            self.userNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.userNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
            
        ])
    }
    
    public func setUpViewContact(contact: Contact) {
        self.setUserName(userName: contact.name ?? "")
    }
    
    public func setUpViewConversation(_ conversation: Conversation) {
        let attributedText = NSMutableAttributedString(string: conversation.name ?? "", attributes: [NSAttributedString.Key.font: UIFont(name: CustomFont.poppinsMedium, size: 16) ?? UIFont(), NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        attributedText.append(NSAttributedString(string: "\n\(conversation.lastMessage ?? "")", attributes: [NSAttributedString.Key.font: UIFont(name: CustomFont.poppinsMedium, size: 14) ?? UIFont(), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        
        self.userNameLabel.attributedText = attributedText
    }
    
    public func setUserName(userName: String) {
        let attributedText = NSMutableAttributedString(string: userName, attributes: [NSAttributedString.Key.font: UIFont(name: CustomFont.poppinsMedium, size: 16) ?? UIFont(), NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        self.userNameLabel.attributedText = attributedText
    }
    
}
