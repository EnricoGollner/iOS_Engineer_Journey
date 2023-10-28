//
//  HomeViewController.swift
//  APINetworkSecondProject
//
//  Created by Enrico Sousa Gollner on 28/10/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var homeView: HomeView = HomeView(frame: .zero)
    private let homeViewModel = HomeViewModel()
    
    override func loadView() {
        self.view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.delegate = self
    }

}

extension HomeViewController: HomeViewDelegate {
    func getPeople() {
        homeViewModel.fetchRequest()
    }
}
