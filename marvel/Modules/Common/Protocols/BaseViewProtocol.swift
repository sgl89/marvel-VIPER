//
//  CommonViewProtocol.swift
//  marvel
//
//  Created by Sonia Giraldez on 14/05/2020.
//  Copyright © 2020 Sonia Giraldez. All rights reserved.
//

import Foundation
import SVProgressHUD

protocol BaseViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func executeSegue(identifier: String, sender: Any?)
    func showAlert(title: String, message: String, closeAction: (() -> Void)?)
}

extension UIViewController: BaseViewProtocol {
    func showLoading() {
        DispatchQueue.main.async {
            SVProgressHUD.setMaxSupportedWindowLevel(UIWindow.Level(rawValue: 1001))
            SVProgressHUD.setDefaultMaskType(.gradient)
            SVProgressHUD.show()
        }
    }

    func hideLoading() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    
    func executeSegue(identifier: String, sender: Any?) {
        self.performSegue(withIdentifier: identifier, sender: sender)
    }
    
    func showAlert(title: String, message: String, closeAction: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler: { _ in
            closeAction?()
        }))
        present(alert, animated: true, completion: nil)
    }
}
