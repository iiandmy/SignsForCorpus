//
//  ModuleBuilder.swift
//  SignsForCorpus
//
//  Created by IlyaCool on 23.07.22.
//

import UIKit

protocol ModuleBuilderProtocol {
    static func buildCitiesModule() -> UIViewController
    static func buildSignsModule() -> UIViewController
}

class ModuleBuilder: ModuleBuilderProtocol {
    static func buildCitiesModule() -> UIViewController {
        let citiesVC = CitiesViewController()
        let citiesPresenter = CitiesPresenter(view: citiesVC)
        citiesVC.presenter = citiesPresenter
        let navController = UINavigationController(rootViewController: citiesVC)
        return navController
    }
    
    static func buildSignsModule() -> UIViewController {
        let signsVC = SignsViewController()
        let signsPresenter = SignsPresenter(view: signsVC)
        signsVC.presenter = signsPresenter
        let navController = UINavigationController(rootViewController: signsVC)
        return navController
    }
}
