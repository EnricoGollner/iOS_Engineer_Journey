//
//  HomeViewController.swift
//  PrimeiroAppNetworkCurso
//
//  Created by Enrico Sousa Gollner on 23/10/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        viewModel.fetchRequest()
    }


}

