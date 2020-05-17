//
//  UIWindowExtension.swift
//  marvel
//
//  Created by Sonia Giraldez on 15/05/2020.
//  Copyright © 2020 Sonia Giraldez. All rights reserved.
//

import Foundation
import UIKit

extension UIWindow {

    public static func getMainUIWindow() -> UIWindow? {
        return UIApplication.shared.windows.first
    }
}
