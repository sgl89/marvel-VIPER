//
//  NavigationProtocol.swift
//  marvel
//
//  Created by Sonia Giraldez on 16/05/2020.
//  Copyright © 2020 Sonia Giraldez. All rights reserved.
//

import Foundation
import UIKit

protocol NavigationProtocol {
    func setIconNavBar()
}

extension UIViewController: NavigationProtocol {
    func setIconNavBar() {
        let logo = UIImage(named: "nav_logo")
        let imageView = UIImageView(image: logo)

        self.navigationItem.titleView = imageView
    }
}
