//
//  PersonTableViewCell.swift
//  APINetworkSecondProject
//
//  Created by Enrico Sousa Gollner on 28/10/23.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: PersonTableViewCell.self)
    
    lazy var cellScreen: PersonTableViewCellScreen = {
        let view = PersonTableViewCellScreen()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubView()
        setUpConstraints()
    }
    
    private func addSubView() {
        contentView.addSubview(cellScreen)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            cellScreen.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellScreen.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellScreen.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellScreen.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    public func setUpPersonCell(data: Person) {
        cellScreen.nameLabel.text = "Nome: \(data.name)"
        cellScreen.surnameLabel.text = "Sobrenome: \(data.lastName)"
        cellScreen.phoneLabel.text = "Idade: \(data.age) anos"
    }
 
}
