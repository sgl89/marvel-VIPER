//
//  CharacterDetailInteractor.swift
//  marvel
//
//  Created by Sonia Giraldez on 16/05/2020.
//  Copyright © 2020 Sonia Giraldez. All rights reserved.
//

import Foundation

class CharacterDetailInteractor : CharacterDetailInteractorProtocol {
    var presenter: CharacterDetailPresenterProtocol?
    var dataSource: Character?
        
    var characterProvider: CharacterProvider = CharacterProvider()
      
    func getCharacter() {
        guard let character = dataSource, let characterId = character.id else { return }
        characterProvider.getCharacter(characterId) { [weak self] (success, response) in
            if success, let character = response?.data?.first {
                self?.dataSource = character
                self?.getComicsForCharacter()
            } else {
                self?.presenter?.showError(message: response?.error?.status ?? "Ha ocurrido un error")
            }
        }
    }
    
    func getComicsForCharacter() {
        guard let character = dataSource, let characterId = character.id else { return }
        characterProvider.getComicsForCharacter(characterId) { [weak self] (success, response) in
            if success, let comics = response?.data {
                self?.dataSource?.comics = comics
                self?.presenter?.showCharacter()
            } else {
                self?.presenter?.showError(message: response?.error?.status ?? "Ha ocurrido un error")
            }
        }
    }
    
    func getCharacterThumbnailURL() -> String {
        return dataSource?.thumbnail?.getImageURL() ?? ""
    }
    
    func getComics() -> [Comic]? {
        return dataSource?.comics
    }
    
    func getComic(_ index: Int) -> Comic? {
        return dataSource?.comics?[index]
    }
}
