//
//  HomeViewModel.swift
//  SecondProjectAPINetworkRequest
//
//  Created by Enrico Sousa Gollner on 30/10/23.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    func success()
    func error(message: String)
}

class HomeViewModel: NSObject {
    
    private var service: HomeService = HomeService()
    private var personList: [Person] = []
    private weak var delegate: HomeViewModelProtocol?
    
    public func delegate(delegate: HomeViewModelProtocol?) {
        self.delegate = delegate
    }
    
    public func fetchRequest() {
        service.getPeople { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                personList = success.people
                delegate?.success()
            case .failure(let failure):
                delegate?.error(message: failure.errorDescription ?? "")
            }
        }
    }
    
    public var numberOfRowsInSection: Int {
        return personList.count
    }
    
    func loadCurrentPerson(indexPath: IndexPath) -> Person {
        return personList[indexPath.row]
    }

}
