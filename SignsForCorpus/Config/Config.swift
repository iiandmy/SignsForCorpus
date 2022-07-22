//
// Created by IlyaCool on 22.07.22.
//

import Foundation
import CoreGraphics

struct Config {
    enum Language: Int {
        case belorussian = 1
        case czech = 2
        case russian = 3
        case english = 4
    }

    struct Constants {
        static let imageMaxSize: CGFloat = 50
    }
}
