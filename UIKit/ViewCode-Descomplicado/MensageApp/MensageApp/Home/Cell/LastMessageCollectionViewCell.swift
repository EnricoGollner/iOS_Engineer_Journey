//
//  LastMessageCollectionViewCell.swift
//  MensageApp
//
//  Created by Enrico Sousa Gollner on 11/12/23.
//

import UIKit

class LastMessageCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: LastMessageCollectionViewCell.self)
    
    lazy var imageView: UIImageView = {
        let imgView: UIImageView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = false
        imgView.image = UIImage(systemName: "person.badge.plus")
        
        return imgView
    }()
    
    lazy var userNameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Adicionar novo contato"
        label.font = UIFont(name: CustomFont.poppinsMedium, size: 16)
        label.textColor = .darkGray
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpVisualElements()
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
}
