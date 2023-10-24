//
//  PeopleList.swift
//  PrimeiroAppNetworkCurso
//
//  Created by Enrico Sousa Gollner on 23/10/23.
//

import Foundation

struct PeopleList: Codable {
    var people: [Person]
    
    enum CodingKeys: String, CodingKey {
        case people = "pessoas"  // in API, the key is "pessoas"
    }
}
