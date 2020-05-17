//
//  CharacterDetailPresenter.swift
//  marvel
//
//  Created by Sonia Giraldez on 16/05/2020.
//  Copyright © 2020 Sonia Giraldez. All rights reserved.
//

import Foundation

class CharacterDetailPresenter: CharacterDetailPresenterProtocol {
    weak var view: CharacterDetailViewProtocol?
    var interactor: CharacterDetailInteractorProtocol?
    var router: CharacterDetailRouterProtocol?
                
    func viewDidLoad() {
        view?.showDetail()
        loadCharacter()
    }
    
    private func loadCharacter() {
        view?.showLoading()
        interactor?.getCharacter()
    }
    
    func showCharacter() {
        view?.hideLoading()
        view?.showDetail()
    }
    
    func showError(message: String) {
        view?.hideLoading()
        view?.showAlert(title: "Error".localized, message: message, closeAction: nil)
    }
    
    func getImage() -> String {
        return interactor?.getCharacterThumbnailURL() ?? ""
    }
    
    func getName() -> String {
        return interactor?.dataSource?.name ?? ""
    }
    
    func getDescription() -> String {
        return interactor?.dataSource?.description ?? ""
    }
    
    func getComics() -> [Comic] {
        return interactor?.dataSource?.comics ?? []
    }
}
