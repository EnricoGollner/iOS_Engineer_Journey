//
//  HomeView.swift
//  APINetworkFirstProject
//
//  Created by Enrico Sousa Gollner on 28/10/23.
//

import UIKit

protocol HomeViewDelegate {
    func fetchRequest()
}

class HomeView: UIView {
    var delegate: HomeViewDelegate?
    
    //Elements
    lazy var requestButton: UIButton = {
        let reqButton = UIButton()
        reqButton.translatesAutoresizingMaskIntoConstraints = false
        reqButton.setTitle("Request", for: .normal)
        reqButton.setTitleColor(.blue, for: .normal)
        reqButton.backgroundColor = .white
        reqButton.layer.cornerRadius = 10
        
        reqButton.addTarget(self, action: #selector(fetch), for: .touchUpInside)
        
        return reqButton
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        addElements()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(requestButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            requestButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            requestButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    //MARK: - Functionalities
    @objc func fetch() {
        print("Ação da função \(#function) disparada")
        delegate?.fetchRequest()
    }
    
}
