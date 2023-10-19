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
        print("Decodificado:")
        print("Nome: \(person.name!)")
    } catch {
        print("Erro ao decodificar o JSON: \(error)")
    }
}
