//
// Created by IlyaCool on 22.07.22.
//

import Foundation

struct CityDTO: Codable {
    private enum CodingKeys: String, CodingKey {
        case cityId = "id"
        case name
        case region
        case image = "logo"
        case lang
    }

    let cityId: Int
    let name: String
    let region: String
    let image: String
    let lang: Int
}

// MARK: Mapping

extension CityDTO {
    func toDomain() {}
}