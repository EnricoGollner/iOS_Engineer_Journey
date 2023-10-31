//
//  HomeViewController.swift
//  APINetworkSecondProject
//
//  Created by Enrico Sousa Gollner on 28/10/23.
//
import UIKit

class HomeViewController: UIViewController {
    
    var screen: HomeView?
    private let viewModel: HomeViewModel = HomeViewModel()
    
    override func loadView() {
        self.screen = HomeView()
        self.view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchRequest()
        viewModel.delegate(delegate: self)
    }
}


extension HomeViewController: HomeViewModelProtocol {
    func error(message: String) {
        let alertController: UIAlertController = UIAlertController(title: "Ops, tivemos um problema", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(ok)
        present(alertController, animated: true)
    }
    
    func success() {
        screen?.configTableViewProtocols(delegate: self, dataSource: self)
        screen?.tableView.reloadData()
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let personCell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.identifier, for: indexPath) as? PersonTableViewCell
        personCell?.setUpPersonCell(data: viewModel.loadCurrentPerson(indexPath: indexPath))
        return personCell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
