//
//  SignsPresenter.swift
//  SignsForCorpus
//
//  Created by IlyaCool on 23.07.22.
//

import Foundation

protocol SignsPresenterProtocol {
    
}

class SignsPresenter: SignsPresenterProtocol {
    var view: SignsViewProtocol!
    
    init(view: SignsViewProtocol) {
        self.view = view
    }
}
