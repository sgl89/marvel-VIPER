//
//  CharacterServerManager.swift
//  marvel
//
//  Created by Sonia Giraldez on 14/05/2020.
//  Copyright © 2020 Sonia Giraldez. All rights reserved.
//

import Alamofire
import Foundation

protocol CharacterServerManager {
    func getCharacters(numberOfItems: Int, searchText: String?, completion: APICompletion<[Character], ErrorResponse>?)
    func getCharacter(characterId: Int, completion: APICompletion<[Character], ErrorResponse>?)
    func getComicsForCharacter(characterId: Int, completion: APICompletion<[Comic], ErrorResponse>?)
}

extension ServerManager: CharacterServerManager {
    func getCharacters(numberOfItems: Int, searchText: String?, completion: APICompletion<[Character], ErrorResponse>?) {
        let urlString = "/v1/public/characters"
        
        var parameters: [String : Any] = ["orderBy": "name",
                                          "limit": numberOfItems]
        
        if let searchText = searchText {
            parameters["nameStartsWith"] = searchText
        }
        
        secureRequest(endPoint: urlString,
                      method: .get,
                      parameters: parameters,
                      completion: completion)
    }
    
    func getCharacter(characterId: Int, completion: APICompletion<[Character], ErrorResponse>?) {
        let urlString = "/v1/public/characters/\(characterId)"
        
        secureRequest(endPoint: urlString,
                      method: .get,
                      completion: completion)
    }

    func getComicsForCharacter(characterId: Int, completion: APICompletion<[Comic], ErrorResponse>?) {
        let urlString = "/v1/public/characters/\(characterId)/comics"
        
        let parameters: [String : Any] = ["orderBy": "title"]
        
        secureRequest(endPoint: urlString,
                      method: .get,
                      parameters: parameters,
                      completion: completion)
    }
}
