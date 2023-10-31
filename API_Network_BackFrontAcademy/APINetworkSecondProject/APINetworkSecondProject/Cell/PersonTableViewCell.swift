//
//  HomeTableViewCell.swift
//  Projeto-network
//
//  Created by Enrico Gollner on 30/10/23.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    static let identifier: String = "CustomTableViewCell"

    lazy var screen: PersonTableViewCellScreen = {
        let view = PersonTableViewCellScreen()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubView()
        setupConstraints()
    }
    
    private func addSubView() {
        contentView.addSubview(screen)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            screen.topAnchor.constraint(equalTo: contentView.topAnchor),
            screen.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            screen.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            screen.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    public func setUpPersonCell(data: Person) {
        screen.nameLabel.text = "Nome: \(data.name)"
        screen.surnameLabel.text = "Sobrenome: \(data.lastName)"
        screen.phoneLabel.text = "Idade: \(data.age)"
    }
}
