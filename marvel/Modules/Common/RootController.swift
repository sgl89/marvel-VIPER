//
//  RootController.swift
//  marvel
//
//  Created by Sonia Giraldez on 17/05/2020.
//  Copyright © 2020 Sonia Giraldez. All rights reserved.
//

import Foundation
import UIKit

public class RootController {
    static let shared = RootController()

    func initApp() {
        CharacterListRouter.launchModule()
    }
}
