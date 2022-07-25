//
//  SignsPresenter.swift
//  SignsForCorpus
//
//  Created by IlyaCool on 23.07.22.
//

import Foundation
import UIKit

protocol SignsPresenterProtocol: Routing, Networking {
    typealias ImageResponse = (Data?, Error?) -> Void
    var view: SignsViewProtocol! { get set }
    var signs: [Sign]! { get set }
    func fetchImage(forUrl url: String, completion: @escaping ImageResponse)
    func showDescription(forSign sign: Sign)
}

class SignsPresenter: SignsPresenterProtocol {
    var view: SignsViewProtocol!
    var router: RouterProtocol!
    var networkClient: NetworkClientProtocol!
    var signs: [Sign]!
    
    init(_ router: RouterProtocol, view: SignsViewProtocol, signs: [Sign], networkClient: NetworkClientProtocol) {
        self.view = view
        self.router = router
        self.networkClient = networkClient
        self.signs = signs
        view.success(signs)
    }
    
    func fetchImage(forUrl url: String, completion: @escaping (Data?, Error?) -> Void) {
        networkClient.fetchImage(url, completion: completion)
    }
    
    func showDescription(forSign sign: Sign) {
        router.showMore(forSign: sign)
    }
}
