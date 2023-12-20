//
//  LoginViewController.swift
//  MensageApp
//
//  Created by Enrico Sousa Gollner on 04/12/23.
//

import UIKit

class LoginViewController: UIViewController {
    lazy var loginView: LoginView = {
        let view = LoginView(frame: .zero)
        return view
    }()
    
    lazy var alert: Alert = {
        let alert = Alert(controller: self)
        return alert
    }()

    override func loadView() {
        self.view = self.loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.configTextFieldDelegate(delegate: self)
        loginView.delegate(delegate: self)
        self.dismissKeyboardOnTouch()
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {}
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        loginView.textFieldValidation()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension LoginViewController: LoginViewProtocol {
    func loginTapped() {
        let email = self.loginView.getEmail()
        let password = self.loginView.getPassword()
        
        let manager = UserManager(business: UserBusiness())
        
        manager.login(email: email, password: password) { userModel in  // Success
            let homeVC: HomeViewController = HomeViewController()
            let navVC = UINavigationController(rootViewController: homeVC)
            navVC.modalPresentationStyle = .fullScreen
            self.present(navVC, animated: true)
        } failureHandler: { error in
            self.alert.getAlert(title: "Erro", message: error.localizedDescription)
        }

    }

    func registerTapped() {
        let registerVC = RegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
}
