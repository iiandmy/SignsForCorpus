//
// Created by IlyaCool on 22.07.22.
//

import Foundation

struct SignDTO: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case cityId = "city_id"
        case name
        case text
        case lang
        case imageUrl = "logo"
        case pictures = "images"
    }

    let id: Int
    let cityId: Int
    let name: String
    let text: String
    let lang: Int
    let imageUrl: String
    let pictures: [String]
}

// MARK: Mapping

extension SignDTO {
    func toDomain() -> Sign {
        .init(id: id,
                cityId: cityId,
                name: name,
                description: text,
                lang: Config.Language(rawValue: lang) ?? .english,
                imageUrl: imageUrl,
                picturesUrl: pictures)
    }
}

