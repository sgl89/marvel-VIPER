//
//  ListServer.swift
//  marvel
//
//  Created by Sonia Giraldez on 14/05/2020.
//  Copyright © 2020 Sonia Giraldez. All rights reserved.
//

import Foundation

class CharacterProvider {
    let manager: CharacterServerManager = ServerManager.sharedInstance
    
    func getCharacters(numberOfItems: Int, searchText: String?, completion: APICompletion<[Character], ErrorResponse>?) {
        manager.getCharacters(numberOfItems: numberOfItems, searchText: searchText) { (success, result) in
            completion?(success, result)
        }
    }
    
    func getCharacter(_ characterId: Int, completion: APICompletion<[Character], ErrorResponse>?) {
        manager.getCharacter(characterId: characterId, completion: completion)
    }
    
    func getComicsForCharacter(_ characterId: Int, completion: APICompletion<[Comic], ErrorResponse>?) {
        manager.getComicsForCharacter(characterId: characterId, completion: completion)
    }
}
