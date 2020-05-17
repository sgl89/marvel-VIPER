//
//  StoryboardHandler.swift
//  marvel
//
//  Created by Sonia Giraldez on 17/05/2020.
//  Copyright © 2020 Sonia Giraldez. All rights reserved.
//

import Foundation

import UIKit

enum StoryboardName: String {
    case main           = "Main"
    case characters     = "Characters"
}

enum ViewControllerId: String {
    case characterList      = "CharacterListViewController"
    case characterDetail    = "CharacterDetailViewController"

    var storyboard: StoryboardName {
        switch self {
        case .characterList, .characterDetail:
            return .characters
        }
    }
}

class StoryboardHandler {
    static func instantiateViewController(_ identifier: ViewControllerId) -> UIViewController {
        return UIStoryboard(name: identifier.storyboard.rawValue, bundle: nil).instantiateViewController(withIdentifier: identifier.rawValue)
    }

    static func instantiateInitialViewController(_ storyboard: StoryboardName) -> UIViewController {
        guard let initialViewController = UIStoryboard(name: storyboard.rawValue, bundle: nil).instantiateInitialViewController() else {
            assertionFailure("There is not view controller set as root for this storyboard")
            return UIViewController()
        }
        return initialViewController
    }
}
