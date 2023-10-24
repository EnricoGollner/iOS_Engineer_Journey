import UIKit

// Decodable - JSON para Objeto
// Protocolo que permite que permite que convertamos dados no formato JSON em um objeto Swift (decodificação).

// Encodable - Objeto para JSON
// Protocolo que permite que convertamos um objeto Swift para dados no formato JSON (codificação).

// Codable - Decodable e Encodable
// Permite ambos. Tanto a decodificação como a codificação de um objeto.


//Levando em conta o JSON:
//{
//    "name_App": "Enrico",
//    "last_name_App": "Gollner",
//    "age_App": 19,
//    "list": [
//        "example",
//        "example"
//    ]
//}

struct Person: Codable {
    var name: String?
    var lastName: String?
    var age: Int?
    var list: [String]
    
    // Mapeamento ocorrendo com CodingKeys
    enum CodingKeys: String, CodingKey {
        case name = "name_App"
        case lastName = "last_name_App"
        case age = "age_App"
        case list // Como tem o mesmo nome, não preciso mapeá-lo aqui
    }
}


// Decodificando JSON em objeto Swift:
let jsonString = """
{
    "name_App": "Enrico",
    "last_name_App": "Gollner",
    "age_App": 19,
    "list": [
        "example",
        "example"
    ]
}
"""

let jsonDecoder = JSONDecoder()

if let jsonData = jsonString.data(using: .utf8) {
    do {
        let person: Person = try jsonDecoder.decode(Person.self, from: jsonData)
        
        print("Deu certo! Objeto com informações de \(person.name ?? "") decodificado!")
    } catch {
        print("Erro ao decodificar JSON \(error)")
    }
}

// Codificando um Objeto Swift para JSON

let people: [Person] = [
    Person(name: "Enrico", lastName: "Gollner", age: 19, list: [""]),
    Person(name: "Cacau", lastName: "Sonsini", age: 19, list: [""]),
]

let jsonEncoder: JSONEncoder = JSONEncoder()
jsonEncoder.outputFormatting = .prettyPrinted

do {
    let jsonData = try jsonEncoder.encode(people)  // Codifica da forma descrita no enum que conforma com String e CodingKey
    
    if let jsonString = String(data: jsonData, encoding: .utf8) {
        print("JSON codificado:")
        print(jsonString)
    }
    
} catch {
    print("Erro ao codificar em JSON: \(error)")
}
