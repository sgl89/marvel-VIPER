//
//  Thumbnail.swift
//  marvel
//
//  Created by Sonia Giraldez on 17/05/2020.
//  Copyright © 2020 Sonia Giraldez. All rights reserved.
//

import Foundation

struct Thumbnail: Codable {
    let path: String?
    let extensionPath: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case extensionPath = "extension"
    }
    
    func getImageURL() -> String? {
        guard let path = path, let extensionPath = extensionPath else {
            return nil
        }
        
        return path + "." + extensionPath
    }
}
