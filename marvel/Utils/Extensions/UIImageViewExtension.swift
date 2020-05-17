//
//  UIImageViewExtension.swift
//  marvel
//
//  Created by Sonia Giraldez on 15/05/2020.
//  Copyright © 2020 Sonia Giraldez. All rights reserved.
//

import AlamofireImage

import Foundation

extension UIImageView {
    func loadImageFromUrlString(_ urlString: String) {
        let placholderImage = UIImage(named: "placeholder")

        if let url = URL(string: urlString) {
            
            self.af_setImage(withURL: url, placeholderImage: placholderImage) { response in
                self.image = response.result.value
            }
        }
    }
}
