//
//  CitiesViewController.swift
//  SignsForCorpus
//
//  Created by IlyaCool on 22.07.22.
//
//

import UIKit

protocol CitiesViewProtocol {
    func success(_ cities: [City])
    func failure(_ error: Error)
}

class CitiesViewController: UIViewController {
    var presenter: CitiesPresenterProtocol!
    
    private let citiesTable = UITableView()
    private let citiesCellIdentifier = "citiesCell"
    private var citiesTableCurrentState: [City]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        title = "Cities"
        setupUI()
        setupConstraints()
        presenter.fetch()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(citiesTable)
        setupTableView()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            citiesTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            citiesTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            citiesTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            citiesTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        citiesTable.dataSource = self
        citiesTable.delegate = self
        citiesTable.translatesAutoresizingMaskIntoConstraints = false
        citiesTable.register(UITableViewCell.self, forCellReuseIdentifier: citiesCellIdentifier)
    }

}

extension CitiesViewController: CitiesViewProtocol {
    func success(_ cities: [City]) {
        DispatchQueue.main.async {
            self.citiesTableCurrentState = cities
            self.citiesTable.reloadData()
        }
    }

    func failure(_ error: Error) {
        DispatchQueue.main.async {
            UIAlertController.showErrorController("Error Occured!", withMessage: error.localizedDescription, self)
        }
    }
}

extension CitiesViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let currentState = citiesTableCurrentState else {
            return 0
        }
        
        return currentState.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = citiesTable.dequeueReusableCell(withIdentifier: citiesCellIdentifier, for: indexPath)
    
        guard let cityForCell = citiesTableCurrentState?[indexPath.row] else { return cell }
        
        var contentConfiguration = cell.defaultContentConfiguration()
        
        contentConfiguration.text = cityForCell.name
        contentConfiguration.secondaryText = cityForCell.region
        NetworkClient.shared.fetchImage(cityForCell.imageUrl) { image, error in
            if let _ = error { return }
            contentConfiguration.image = image
            contentConfiguration.imageProperties.maximumSize = CGSize(width: 50, height: 50)
            cell.contentConfiguration = contentConfiguration
        }
        
        cell.contentConfiguration = contentConfiguration
        
        return cell
    }
}
