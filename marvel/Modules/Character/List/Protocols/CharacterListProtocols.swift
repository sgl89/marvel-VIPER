//
//  CharacterListProtocols.swift
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
protocol CharacterListViewProtocol: BaseViewProtocol {
    func showData()
}

//----------------------------
// MARK: - Interactor
//----------------------------
protocol CharacterListInteractorProtocol {
    var presenter: CharacterListPresenterProtocol? { get set }
    var dataSource: [Character]? { get }
    
    func getCharacters(numberOfItems: Int, searchText: String?)
}

//----------------------------
// MARK: - Presenter
//----------------------------
protocol CharacterListPresenterProtocol: BasePresenterProtocol {
    var view: CharacterListViewProtocol? { get set }
    var interactor: CharacterListInteractorProtocol? { get set }
    var router: CharacterListRouterProtocol? { get set }
    
    func showCharacters()
    func showError(message: String)
    
    func charactersToShow() -> [Character]
    func selectIndex(_ index: Int)
    
    func scrollBottom()
    func searchByText(_ text: String?)
}

//----------------------------
// MARK: - Router
//----------------------------
protocol CharacterListRouterProtocol : BaseRouterProtocol {
    static func launchModule() -> CharacterListRouterProtocol?
    func goToDetail(character: Character, from view: UIViewController)
}
