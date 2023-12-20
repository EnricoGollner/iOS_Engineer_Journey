//
//  OutgoingTextMessageTableViewCell.swift
//  MensageApp
//
//  Created by Enrico Sousa Gollner on 19/12/23.
//

import UIKit

class OutgoingTextMessageTableViewCell: UITableViewCell {
    
    static let identifier: String = String(describing: OutgoingTextMessageTableViewCell.self)

    lazy var myMessageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = CustomColor.appPurple
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return view
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0  // knows the number it needs based in the text
        label.textColor = .white
        label.font = UIFont(name: CustomFont.poppinsBold, size: 14)
        
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
        self.addSubview(myMessageView)
        self.myMessageView.addSubview(messageLabel)
        self.isSelected = false
        
        self.configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            self.myMessageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.myMessageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.myMessageView.widthAnchor.constraint(lessThanOrEqualToConstant: 250),  // the width of the UIView expands with the text size
            
            self.messageLabel.leadingAnchor.constraint(equalTo: self.myMessageView.leadingAnchor, constant: 15),
            self.messageLabel.topAnchor.constraint(equalTo: self.myMessageView.topAnchor, constant: 15),
            self.messageLabel.bottomAnchor.constraint(equalTo: self.myMessageView.bottomAnchor, constant: -15),
            self.messageLabel.trailingAnchor.constraint(equalTo: self.myMessageView.trailingAnchor, constant: -15)
        ])
    }
    
    public func setUpCell(message: Message?) {
        self.messageLabel.text = message?.message ?? ""
    }

}
