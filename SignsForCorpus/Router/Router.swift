//
//  Router.swift
//  SignsForCorpus
//
//  Created by IlyaCool on 23.07.22.
//

import Foundation
import UIKit

protocol RouterProtocol {
    static func routeToSignsModule(forCity cityId: Int, _ sender: UIViewController)
    static func routeToSignDescriptionModule(forSign sign: Sign, _ sender: UIViewController)
}

class Router: RouterProtocol {
    static func routeToSignsModule(forCity cityId: Int, _ sender: UIViewController) {
        let signsModule = 
    }
    
    static func routeToSignDescriptionModule(forSign sign: Sign, _ sender: UIViewController) {
        
    }
}
