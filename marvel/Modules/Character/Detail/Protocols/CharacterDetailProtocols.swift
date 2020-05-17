//
//  CharacterDetailProtocols.swift
//  marvel
//
//  Created by Sonia Giraldez on 17/05/2020.
//  Copyright © 2020 Sonia Giraldez. All rights reserved.
//

import Foundation
import UIKit

//----------------------------
// MARK: - View
//----------------------------
protocol CharacterDetailViewProtocol: BaseViewProtocol {
    func showDetail()
}

//----------------------------
// MARK: - Interactor
//----------------------------
protocol CharacterDetailInteractorProtocol {
    var presenter: CharacterDetailPresenterProtocol? { get set }
    var dataSource: Character? { get set }
    
    func getCharacter()
    func getCharacterThumbnailURL() -> String
    
    func getComics() -> [Comic]?
    func getComic(_ index: Int) -> Comic?
}

//----------------------------
// MARK: - Presenter
//----------------------------
protocol CharacterDetailPresenterProtocol: BasePresenterProtocol {
    var view: CharacterDetailViewProtocol? { get set }
    var interactor: CharacterDetailInteractorProtocol? { get set }
    var router: CharacterDetailRouterProtocol? { get set }
        
    func showCharacter()
    func showError(message: String)
    
    func getImage() -> String
    func getName() -> String
    func getDescription() -> String
    func getComics() -> [Comic]
}

//----------------------------
// MARK: - Router
//----------------------------
protocol CharacterDetailRouterProtocol : BaseRouterProtocol {
    static func launchModule(navigationType: NavigationRouterType, from: UIViewController?, dataSource: Character?) -> CharacterDetailRouterProtocol?
}
