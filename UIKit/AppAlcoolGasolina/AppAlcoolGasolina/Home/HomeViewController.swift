//
//  ViewController.swift
//  AppAlcoolGasolina
//
//  Created by Enrico Sousa Gollner on 12/11/23.
//

import UIKit

class HomeViewController: UIViewController {
    lazy var homeView = HomeView(frame: .zero)
    
    override func loadView() {
        self.view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

