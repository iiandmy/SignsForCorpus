//
//  DescriptionPresenter.swift
//  SignsForCorpus
//
//  Created by IlyaCool on 25.07.22.
//

import Foundation

protocol DescriptionPresenterProtocol: Routing, Networking {
    typealias ImageResponse = (Data?, Error?) -> Void
    
    var view: DescriptionViewProtocol! { get set }
    func fetchImage(inUrl url: String, completion: @escaping ImageResponse)
}

class DescriptionPresenter: DescriptionPresenterProtocol {
    var router: RouterProtocol!
    var view: DescriptionViewProtocol!
    var networkClient: NetworkClientProtocol!
    
    init(_ router: RouterProtocol, view: DescriptionViewProtocol, sign: Sign, networkClient: NetworkClientProtocol) {
        self.router = router
        self.view = view
        self.networkClient = networkClient
        self.view.set(sign: sign)
    }
    
    func fetchImage(inUrl url: String, completion: @escaping ImageResponse) {
        networkClient.fetchImage(url, completion: completion)
    }
}
