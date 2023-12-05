//
//  ViewController.swift
//  MensageApp
//
//  Created by Enrico Sousa Gollner on 04/12/23.
//

import UIKit

class HomeViewController: UIViewController {
    lazy var homeView: UIView = {
        let homeView = HomeView(frame: .zero)
        homeView.translatesAutoresizingMaskIntoConstraints = false
        return homeView
    }()
    
    override func loadView() {
        self.view = self.homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboard()
    }
}

