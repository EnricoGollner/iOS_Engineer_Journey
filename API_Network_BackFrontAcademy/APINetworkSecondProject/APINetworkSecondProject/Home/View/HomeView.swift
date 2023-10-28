//
//  HomeView.swift
//  APINetworkSecondProject
//
//  Created by Enrico Sousa Gollner on 28/10/23.
//

import UIKit

protocol HomeViewDelegate {
    func getPeople()
}

class HomeView: UIView {
    public var delegate: HomeViewDelegate?
    
    //MARK: - Elements
    lazy var requestButton: UIButton = {
        let reqBt = UIButton()
        reqBt.translatesAutoresizingMaskIntoConstraints = false
        reqBt.setTitle("Request", for: .normal)
        reqBt.setTitleColor(.blue, for: .normal)
        reqBt.backgroundColor = .red
        reqBt.layer.cornerRadius = 10
        reqBt.addTarget(self, action: #selector(fetchRequest), for: .touchUpInside)
        
        return reqBt
    }()
    
    lazy var peopleTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.identifier)
        
        return tableView
    }()
    
    private func configTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        self.peopleTableView.delegate = delegate
        self.peopleTableView.dataSource = dataSource
    }
    

    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Set up visual elements
    private func setUpVisualElements() {
        backgroundColor = .white
        addSubview(requestButton)
        addSubview(peopleTableView)
        
        configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            requestButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            requestButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    //MARK: - Functionalities
    @objc func fetchRequest() {
        delegate?.getPeople()
    }
    
}
