//
//  HomeViewModel.swift
//  APINetworkSecondProject
//
//  Created by Enrico Sousa Gollner on 28/10/23.
//

import UIKit

protocol HomeViewModelDelegate: AnyObject {
    func success()
    func error(message: String)
}

class HomeViewModel {
    private weak var delegate: HomeViewModelDelegate?
    
    private let service = HomeService()
    private var peopleList: [Person] = []
    
    public func fetchRequest() {
        service.getPeople { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let success):
                peopleList = success.people
                delegate?.success()
            case .failure(let failure):
                delegate?.error(message: failure.errorDescription ?? "")
            }
        }
    }
    
    public var numberOfRows: Int {
        return peopleList.count
    }
    
    func loadCurrentPerson(indexPath: IndexPath) -> Person {
        return peopleList[indexPath.row]
    }
}

