//
// Created by IlyaCool on 22.07.22.
//

import Foundation

protocol CitiesPresenterProtocol: Routing, Networking {
    var view: CitiesViewProtocol! { get set }
    var cities: [City]! { get set }
    func fetchData()
    func fetchImage(forUrl url: String, completion: @escaping (Data?, Error?) -> Void)
    func presentSigns(forCity cityId: Int)
}

class CitiesPresenter {
    var view: CitiesViewProtocol!
    var router: RouterProtocol!
    var cities: [City]!
    var signs: [Sign]!
    var networkClient: NetworkClientProtocol!
    
    init(_ router: RouterProtocol, view: CitiesViewProtocol, networkClient: NetworkClientProtocol) {
        self.view = view
        self.router = router
        self.networkClient = networkClient
    }
}

enum CitiesPresenterError: Error, LocalizedError {
    case signsNotLoaded
    
    public var errorDescription: String? {
        switch self {
        case .signsNotLoaded:
            return NSLocalizedString("Signs are not loaded yet", comment: "Signs Not Loaded")
        }
    }
}

extension CitiesPresenter: CitiesPresenterProtocol {
    func fetchData() {
        networkClient.fetchCities { cities, error in
            if let error = error {
                self.view.failure(error)
            }
            guard let cities = cities else { return }
            
            self.cities = cities
            self.view.success(cities.filter {
                $0.lang == .belorussian
            })
        }
        networkClient.fetchSigns { signs, error in
            if let error = error {
                self.view.failure(error)
            }
            guard let signs = signs else { return }
            
            self.signs = signs.filter {
                $0.lang == .belorussian
            }
        }
    }
    
    func presentSigns(forCity cityId: Int) {
        guard let signs = signs else {
            self.view.failure(CitiesPresenterError.signsNotLoaded)
            return
        }
        router.showSigns(signs.filter {
            $0.cityId == cityId &&
            !$0.name.isEmpty
        })
    }
    
    func fetchImage(forUrl url: String, completion: @escaping (Data?, Error?) -> Void) {
        networkClient.fetchImage(url, completion: completion)
    }
}
