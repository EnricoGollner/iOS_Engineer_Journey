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
}
