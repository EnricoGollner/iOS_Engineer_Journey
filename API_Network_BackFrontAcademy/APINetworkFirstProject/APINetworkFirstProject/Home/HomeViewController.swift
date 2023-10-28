//
//  ViewController.swift
//  APINetworkFirstProject
//
//  Created by Enrico Sousa Gollner on 28/10/23.
//

import UIKit

class HomeViewController: UIViewController {
    let homeViewModel = HomeViewModel()
    
    lazy var homeView: HomeView = HomeView(frame: .zero)
    
    override func loadView() {
        self.view = homeView
        homeView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension HomeViewController: HomeViewDelegate {
    func fetchRequest() {
        homeViewModel.fetchRequest()
    }
}

