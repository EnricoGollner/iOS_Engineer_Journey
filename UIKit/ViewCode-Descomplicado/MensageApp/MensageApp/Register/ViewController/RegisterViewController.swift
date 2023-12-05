//
//  RegisterViewController.swift
//  MensageApp
//
//  Created by Enrico Sousa Gollner on 04/12/23.
//

import FirebaseCore
import FirebaseFirestore
import UIKit

class RegisterViewController: UIViewController {
    lazy var registerView: RegisterView = {
        let view = RegisterView(frame: .zero)
        return view
    }()
    
    lazy var alert: Alert = {
        let alert = Alert(controller: self)
        return alert
    }()
    
    var firestore: Firestore?
    
    // MARK: - Life cycle
    override func loadView() {
        self.firestore = Firestore.firestore()
        self.view = registerView
        self.dismissKeyboard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.registerView.configTextFieldDelegate(delegate: self)
        self.registerView.delegate(delegate: self)
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {}
    
    func textFieldDidEndEditing(_ textField: UITextField) {}
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        registerView.textFieldValidation()
        return true
    }
}

extension RegisterViewController: RegisterViewProtocol {
    func tappedBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tappedRegisterButton() {
        let name = self.registerView.getName()
        let email = self.registerView.getEmail()
        let password = self.registerView.getPassword()
        
        let manager = UserManager(business: UserBusiness())
        
        manager.register(email: email, password: password) { userModel in  // Success
            if let userId = userModel.userId {
                self.firestore?.collection("usuarios").document(userId).setData([
                    "id": userId,
                    "name": name,
                    "email": email,
                ])
            }
            
            self.alert.getAlert(title: "Parabéns", message: "Registrado com sucesso!", completion: {
                self.navigationController?.popViewController(animated: true)
            })
        } failureHandler: { error in
            self.alert.getAlert(title: "Erro", message: error.localizedDescription)
        }
    }
}
