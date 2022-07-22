//
// Created by IlyaCool on 22.07.22.
//

import Foundation

struct SignDTO: Codable {
    private enum CodingKeys: String, CodingKey {
        case cityId = "city_id"
        case name
        case text
        case lang
        case image = "logo"
        case pictures = "images"
    }

    let cityId: Int
    let name: String
    let text: String
    let lang: Int
    let image: String
    let pictures: [String]
}

// MARK: Mapping

extension SignDTO {
    func toDomain() {

    }
}

