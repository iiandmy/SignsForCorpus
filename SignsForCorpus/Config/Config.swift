//
// Created by IlyaCool on 22.07.22.
//

import Foundation
import CoreGraphics
import UIKit

struct Config {
    enum Language: Int {
        case belorussian = 1
        case czech = 2
        case russian = 3
        case english = 4
    }

    struct Constants {
        static let imageMaxSize: CGFloat = 50
        static let normalSpacing: CGFloat = 16
        static let minimalSpacing: CGFloat = 8
        static let bigSpacing: CGFloat = 32
        static let picturesCollectionHeight = UIScreen.main.bounds.height / 4
    }
}
