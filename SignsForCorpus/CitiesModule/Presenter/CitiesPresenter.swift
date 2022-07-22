//
// Created by IlyaCool on 22.07.22.
//

import Foundation

protocol CitiesPresenterProtocol {
    func fetch()
}

class CitiesPresenter {
    var view: CitiesViewProtocol!
    var cities: [City]!
    
    init(view: CitiesViewProtocol) {
        self.view = view
    }
}

extension CitiesPresenter: CitiesPresenterProtocol {
    func fetch() {
        NetworkClient.shared.fetchCities { cities, error in
            if let error = error {
                self.view.failure(error)
            }
            guard let cities = cities else { return }
            
            self.view.success(cities.filter {
                $0.lang == .belorussian
            })
        }
    }
}
