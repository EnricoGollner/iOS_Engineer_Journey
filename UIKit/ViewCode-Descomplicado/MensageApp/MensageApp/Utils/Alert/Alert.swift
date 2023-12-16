//
//  Alert.swift
//  MensageApp
//
//  Created by Enrico Sousa Gollner on 04/12/23.
//

import UIKit

class Alert: NSObject {
    private var controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    public func getAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { _ in
            completion?()
        }
        alertController.addAction(cancelAction)
        
        self.controller.present(alertController, animated: true)
    }
    
    func addContactAlert(completion: ((_ value: String) -> Void)? = nil){
        var textFieldAlert: UITextField?
        
        let alert = UIAlertController(title: "Adicionar Usuario", message: "Digite uma email Valido", preferredStyle: .alert)
        
        let add = UIAlertAction(title: "Adicionar", style: .default)  { (acao) in
            completion?(textFieldAlert?.text ?? "")
        }
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        
        alert.addAction(cancel)
        alert.addAction(add)
        
        alert.addTextField(configurationHandler: { (textField: UITextField) in
            textFieldAlert = textField
            textField.placeholder = "Email:"
        })
        
        self.controller.present(alert, animated: true, completion: nil)
    }
}
