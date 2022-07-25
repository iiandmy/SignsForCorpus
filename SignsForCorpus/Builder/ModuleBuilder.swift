//
//  ModuleBuilder.swift
//  SignsForCorpus
//
//  Created by IlyaCool on 23.07.22.
//

import UIKit

protocol ModuleBuilderProtocol {
    func buildCitiesModule(_ router: RouterProtocol) -> UIViewController
    func buildSignsModule(_ router: RouterProtocol, withSigns signs: [Sign]) -> UIViewController
    func buildDetailsModule(_ router: RouterProtocol, forSign sign: Sign) -> UIViewController
}

class ModuleBuilder: ModuleBuilderProtocol {
    private var networkClient: NetworkClientProtocol = NetworkClient()

    func buildCitiesModule(_ router: RouterProtocol) -> UIViewController {
        let citiesVC = CitiesViewController()
        let citiesPresenter = CitiesPresenter(router, view: citiesVC, networkClient: networkClient)
        citiesVC.presenter = citiesPresenter
        return citiesVC
    }
    
    func buildSignsModule(_ router: RouterProtocol, withSigns signs: [Sign]) -> UIViewController {
        let signsVC = SignsViewController()
        let signsPresenter = SignsPresenter(router, view: signsVC,signs: signs, networkClient: networkClient)
        signsVC.presenter = signsPresenter
        return signsVC
    }
    
    func buildDetailsModule(_ router: RouterProtocol, forSign sign: Sign) -> UIViewController {
        let descriptionVC = DescriptionViewController()
        let descriptionPresenter = DescriptionPresenter(router, view: descriptionVC, sign: sign, networkClient: networkClient)
        descriptionVC.presenter = descriptionPresenter
        return descriptionVC
    }
}
