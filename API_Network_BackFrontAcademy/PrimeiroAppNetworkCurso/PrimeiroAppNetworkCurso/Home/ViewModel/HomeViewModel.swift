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
        service.getPersonList(completion: <#T##(Result<PeopleList, NetworkError>) -> Void#>)
    }
}
