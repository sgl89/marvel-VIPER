//
//  CharacterListRouter.swift
//  marvel
//
//  Created by Sonia Giraldez on 15/05/2020.
//  Copyright © 2020 Sonia Giraldez. All rights reserved.
//

import Foundation
import UIKit

class CharacterListRouter: BaseRouter, CharacterListRouterProtocol {


    //----------------------------
    // MARK: - Launcher Initializer
    //----------------------------
    @discardableResult
    static func launchModule() -> CharacterListRouterProtocol? {
    
        if let view = StoryboardHandler.instantiateViewController(.characterList) as? CharacterListViewController {
            
            var interactor: CharacterListInteractorProtocol = CharacterListInteractor()
            let router: CharacterListRouterProtocol = CharacterListRouter()
            var presenter: CharacterListPresenterProtocol = CharacterListPresenter()

            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            
            router.startNavigation(navigationType: .asRootWithNav, view: view, from: nil)
            
            return router
        }
        return nil
    }
    
    //----------------------------
    // MARK: - Navigation methods
    //----------------------------
    func goToDetail(character: Character, from view: UIViewController) {
        CharacterDetailRouter.launchModule(navigationType: .push, from: view, dataSource: character)
    }
}
