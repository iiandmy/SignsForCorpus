//
// Created by IlyaCool on 22.07.22.
//

import Foundation

struct API {
    static let scheme = "https"
    static let host = "krokapp.by"

    enum Path: String {
        case cities = "/api/get_cities/11"
        case signs = "/api/get_points/11"
    }

    static func getUrl(forPath path: API.Path) -> URL {
        var components = URLComponents()

        components.scheme = API.scheme
        components.host = API.host
        components.path = path.rawValue

        return components.url!
    }
}