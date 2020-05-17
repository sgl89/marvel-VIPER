//
//  APIResponse.swift
//  marvel
//
//  Created by Sonia Giraldez on 14/05/2020.
//  Copyright © 2020 Sonia Giraldez. All rights reserved.
//

import Foundation

public typealias APICompletion<T:Any, E:Any> = (_ success: Bool, _ objectResponse: APIResponse<T, E>?) -> Void

//----------------------------
// MARK: - API Result
//----------------------------
public class APIResponse<T:Any, E:Any> {
    public var data: T?
    public var status: String?
    var error: ErrorResponse?
    
    init(data: T? = nil, error: ErrorResponse? = nil, status: String? = nil) {
        self.data = data
        self.status = status
        self.error = error
    }
}
