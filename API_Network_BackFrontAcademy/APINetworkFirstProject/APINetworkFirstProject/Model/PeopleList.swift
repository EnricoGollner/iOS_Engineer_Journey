//
//  PeopleList.swift
//  APINetworkFirstProject
//
//  Created by Enrico Sousa Gollner on 28/10/23.
//

import Foundation

struct PeopleList: Codable {
    var people: [Person]
    
    // Custom Mapping (CodingKeys)
    enum CodingKeys: String, CodingKey {
        case people = "pessoas" // Based on API's response, that's the key we want to get the value from
    }
}
