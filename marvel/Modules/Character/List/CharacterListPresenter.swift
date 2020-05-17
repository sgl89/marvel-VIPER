//
//  ListPresenter.swift
//  marvel
//
//  Created by Sonia Giraldez on 14/05/2020.
//  Copyright © 2020 Sonia Giraldez. All rights reserved.
//

import Foundation
import UIKit

class CharacterListPresenter: CharacterListPresenterProtocol {
    
    weak var view: CharacterListViewProtocol?
    var interactor: CharacterListInteractorProtocol?
    var router: CharacterListRouterProtocol?
    
    var numberOfItems = ListConstants.kNumItems
    
    var searchText: String?
        
    func viewDidLoad() {
        view?.showLoading()
        loadCharacters()
    }
    
    func loadCharacters() {
        interactor?.getCharacters(numberOfItems: numberOfItems, searchText: searchText)
    }
    
    func showCharacters() {
        view?.hideLoading()
        view?.showData()
    }
    
    func charactersToShow() -> [Character] {
        guard let characters = interactor?.dataSource else {
            return []
        }
        
        return characters
    }
    
    func showError(message: String) {
        view?.hideLoading()
        view?.showAlert(title: "Error", message: message, closeAction: nil)
    }
    
    func selectIndex(_ index: Int) {
        guard let character = interactor?.dataSource?[index] else {
            return
        }
        
        router?.goToDetail(character: character, from: view as! UIViewController)
    }
    
    func scrollBottom() {
        let items = numberOfItems + ListConstants.kNumIncrementItems
        if  items <= ListConstants.kNumMaxItems {
            numberOfItems = items
            
            loadCharacters()
        }
    }
    
    func searchByText(_ text: String?) {
        if let text = text, text.isEmpty {
            searchText = nil
        } else {
            searchText = text
        }
        
        loadCharacters()
    }
}
