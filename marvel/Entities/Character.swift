//
//  Character.swift
//  marvel
//
//  Created by Sonia Giraldez on 14/05/2020.
//  Copyright © 2020 Sonia Giraldez. All rights reserved.
//

import Foundation


import Foundation

struct Character: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let thumbnail: Thumbnail?
    var comics: [Comic]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case thumbnail
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id =  try values.decodeIfPresent(Int.self, forKey: .id)
        name =  try values.decodeIfPresent(String.self, forKey: .name)
        description =  try values.decodeIfPresent(String.self, forKey: .description)
        thumbnail =  try values.decodeIfPresent(Thumbnail.self, forKey: .thumbnail)
        comics = []
    }
}
