//
//  CharacterListInteractor.swift
//  marvel
//
//  Created by Sonia Giraldez on 15/05/2020.
//  Copyright © 2020 Sonia Giraldez. All rights reserved.
//

import Foundation

class CharacterListInteractor : CharacterListInteractorProtocol {
    var presenter: CharacterListPresenterProtocol?
    var dataSource: [Character]?
    
    var listProvider: CharacterProvider = CharacterProvider()
      
    func getCharacters(numberOfItems: Int, searchText: String?) {
        listProvider.getCharacters(numberOfItems: numberOfItems, searchText: searchText) { [weak self] (success, response) in
            if success, let characters = response?.data {
                self?.dataSource = characters
                self?.presenter?.showCharacters()
            } else {
                self?.presenter?.showError(message: response?.error?.status ?? "Ha ocurrido un error")
            }
        }
    }
}
