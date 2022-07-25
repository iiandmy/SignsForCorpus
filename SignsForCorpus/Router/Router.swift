//
//  Router.swift
//  SignsForCorpus
//
//  Created by IlyaCool on 23.07.22.
//

import Foundation
import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var moduleBuilder: ModuleBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showSigns(_ signs: [Sign])
    func showMore(forSign sign: Sign)
    func popToRoot()
}

protocol Routing {
    var router: RouterProtocol! { get set }
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var moduleBuilder: ModuleBuilderProtocol?
    
    init(navigationController: UINavigationController, moduleBuilder: ModuleBuilderProtocol) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
    }
    
    func initialViewController() {
        guard let navigationController = navigationController else { return }
        guard let initialController = moduleBuilder?.buildCitiesModule(self) else { return }
        
        navigationController.viewControllers = [initialController]
    }
    
    func showSigns(_ signs: [Sign]) {
        guard let navigationController = navigationController else { return }
        guard let signsController = moduleBuilder?.buildSignsModule(self, withSigns: signs) else { return }
        
        navigationController.pushViewController(signsController, animated: true)
    }
    
    func showMore(forSign sign: Sign) {
        guard let navigationController = navigationController else { return }
        guard let detailsController = moduleBuilder?.buildDetailsModule(self, forSign: sign) else { return }
        
        navigationController.pushViewController(detailsController, animated: true)
    }
    
    func popToRoot() {
        guard let navigationController = navigationController else { return }
        navigationController.popToRootViewController(animated: true)
    }
    
}
