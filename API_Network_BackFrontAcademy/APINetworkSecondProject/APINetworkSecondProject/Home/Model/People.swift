//
//  People.swift
//  APINetworkSecondProject
//
//  Created by Enrico Sousa Gollner on 28/10/23.
//

import Foundation

struct People: Codable {
    var people: [Person]
    
    enum CodingKeys: String, CodingKey {
        case people = "pessoas"
    }
}
