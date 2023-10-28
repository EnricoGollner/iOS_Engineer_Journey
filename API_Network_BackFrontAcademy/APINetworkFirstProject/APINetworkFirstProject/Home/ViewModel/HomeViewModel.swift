//
//  HomeViewModel.swift
//  APINetworkFirstProject
//
//  Created by Enrico Sousa Gollner on 28/10/23.
//

import Foundation

class HomeViewModel {
    private let service: HomeService = HomeService()
    
    public func fetchRequest() {
        service.getPeopleList { result in
            switch (result) {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure.errorDescription ?? "")
            }
        }
    }
}
