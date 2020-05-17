//
//  CharacterDetailRouter.swift
//  marvel
//
//  Created by Sonia Giraldez on 16/05/2020.
//  Copyright © 2020 Sonia Giraldez. All rights reserved.
//

import Foundation
import UIKit

class CharacterDetailRouter: BaseRouter, CharacterDetailRouterProtocol {

    //----------------------------
    // MARK: - Launcher Initializer
    //----------------------------
    @discardableResult
    static func launchModule(navigationType: NavigationRouterType = .push, from: UIViewController? = nil, dataSource: Character?) -> CharacterDetailRouterProtocol? {
    
        if let view = StoryboardHandler.instantiateViewController(.characterDetail) as? CharacterDetailViewController {
            
            var interactor: CharacterDetailInteractorProtocol = CharacterDetailInteractor()
            var presenter: CharacterDetailPresenterProtocol = CharacterDetailPresenter()
            let router: CharacterDetailRouterProtocol = CharacterDetailRouter()
            
            view.presenter = presenter
            interactor.presenter = presenter
            interactor.dataSource = dataSource
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            
            router.startNavigation(navigationType: navigationType, view: view, from: from)
            
             return router
        }

        return nil
    }
}
