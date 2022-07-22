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
        case imageUrl = "logo"
        case pictures = "images"
    }

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
        .init(cityId: cityId,
                name: name,
                description: String(htmlEncodedString: text) ?? text,
                lang: Config.Language(rawValue: lang) ?? .english,
                imageUrl: imageUrl,
                picturesUrl: pictures)
    }
}

