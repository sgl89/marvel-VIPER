//
//  ErrorResponse.swift
//  marvel
//
//  Created by Sonia Giraldez on 14/05/2020.
//  Copyright © 2020 Sonia Giraldez. All rights reserved.
//

import Foundation

//----------------------------
// MARK: - API Error Result
//----------------------------
struct ErrorResponse: Error, Codable {
    var code: Int?
    var status: String?
    
    init(code: Int? = nil, status: String?) {
        self.code = code
        self.status = status
    }
}
