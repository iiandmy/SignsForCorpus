//
//  ModuleBuilder.swift
//  SignsForCorpus
//
//  Created by IlyaCool on 23.07.22.
//

import UIKit

protocol ModuleBuilderProtocol {
    static func buildCitiesModule() -> UIViewController
}

class ModuleBuilder: ModuleBuilderProtocol {
    static func buildCitiesModule() -> UIViewController {
        let citiesVC = CitiesViewController()
        let citiesPresenter = CitiesPresenter(view: citiesVC)
        citiesVC.presenter = citiesPresenter
        let navController = UINavigationController(rootViewController: citiesVC)
        return navController
    }
}
