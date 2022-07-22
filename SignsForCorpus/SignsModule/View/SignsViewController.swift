//
//  SignsViewController.swift
//  SignsForCorpus
//
//  Created by IlyaCool on 23.07.22.
//

import Foundation
import UIKit

protocol SignsViewProtocol {
    func success(_ signs: [Sign])
    func error(_ error: Error)
}

class SignsViewController: UIViewController {
    var presenter: SignsPresenterProtocol!
    
    private let signsTable = UITableView()
    private let signsTableIdentifier = "signsTable"
    private var currentTableState: [Sign]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Signs"
        setup()
    }
    
    func setup() {
        setupUI()
        setupConstraints()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(signsTable)
        setupTable()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            signsTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            signsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            signsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupTable() {
        signsTable.translatesAutoresizingMaskIntoConstraints = false
        signsTable.delegate = self
        signsTable.dataSource = self
        signsTable.register(UITableViewCell.self, forCellReuseIdentifier: signsTableIdentifier)
    }
}

extension SignsViewController: SignsViewProtocol {
    func success(_ signs: [Sign]) {
        DispatchQueue.main.async {
            self.currentTableState = signs
            self.signsTable.reloadData()
        }
    }
    
    func error(_ error: Error) {
        DispatchQueue.main.async {
            UIAlertController.showErrorController("Error Occured!", withMessage: error.localizedDescription, self)
        }
    }
    
    
}

extension SignsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let state = currentTableState else {
            return 0
        }
        
        return state.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->  UITableViewCell {
        let cell = signsTable.dequeueReusableCell(withIdentifier: signsTableIdentifier, for: indexPath)
        
        
        
        return cell
    }
    
}
