//
//  Styles.swift
//  marvel
//
//  Created by Sonia Giraldez on 16/05/2020.
//  Copyright © 2020 Sonia Giraldez. All rights reserved.
//

import Foundation
import UIKit

class Styles {
    static func applyAllStyles() {
        Styles.applyNavBarAppearance()
    }

    static func applyNavBarAppearance() {
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = UIColor.black
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().shadowImage = UIImage.imageWithColor(color: .white)
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
    }
}
