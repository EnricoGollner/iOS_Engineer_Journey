//
//  IncomingTextMessageTableViewCell.swift
//  MensageApp
//
//  Created by Enrico Sousa Gollner on 19/12/23.
//

import UIKit

class IncomingTextMessageTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: IncomingTextMessageTableViewCell.self)
    
    lazy var contactMessage: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.06)
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return view
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0  // knows the number it needs based in the text
        label.textColor = .white
        label.font = UIFont(name: CustomFont.poppinsMedium, size: 14)
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setUpVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpVisualElements() {
        self.addSubview(contactMessage)
        self.contactMessage.addSubview(messageLabel)
        self.isSelected = false  // removing selection of the cell
        
        self.configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            self.contactMessage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.contactMessage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.contactMessage.widthAnchor.constraint(lessThanOrEqualToConstant: 250),  // the width of the UIView expands with the text size
            
            self.messageLabel.leadingAnchor.constraint(equalTo: self.contactMessage.leadingAnchor, constant: 15),
            self.messageLabel.topAnchor.constraint(equalTo: self.contactMessage.topAnchor, constant: 15),
            self.messageLabel.bottomAnchor.constraint(equalTo: self.contactMessage.bottomAnchor, constant: -15),
            self.messageLabel.trailingAnchor.constraint(equalTo: self.contactMessage.trailingAnchor, constant: -15)
        ])
    }
    
    public func setUpCell(message: Message?) {
        self.messageLabel.text = message?.message ?? ""
    }
    
}
