//
//  HomeViewModel.swift
//  PrimeiroAppNetworkCurso
//
//  Created by Enrico Sousa Gollner on 23/10/23.
//

import UIKit

class HomeViewModel: NSObject {
    
    var service: HomeService = HomeService()
    
    public func fetchRequest() {
        service.getPersonList { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure.errorDescription ?? "")
            }
        }
    }
}
