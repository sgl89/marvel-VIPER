//
//  ServerManager.swift
//  marvel
//
//  Created by Sonia Giraldez on 14/05/2020.
//  Copyright © 2020 Sonia Giraldez. All rights reserved.
//


import Alamofire
import Foundation

import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

typealias FailureArrayErrors = (_ errors: [String]?) -> Void

//----------------------------
// MARK: - Decoding Helper
//----------------------------
struct DecodingHelper: Decodable {
    private let decoder: Decoder
    
    init(from decoder: Decoder) throws {
        self.decoder = decoder
    }
    
    func decode(to type: Decodable.Type) throws -> Decodable {
        let decodable = try type.init(from: decoder)
        return decodable
    }
}


class ServerManager {
    static let sharedInstance = ServerManager()

    var manager: SessionManager

    private var keyError: String = "error"
    var keyMessage: String = "message"

    var token: String = ""

    var baseURL = "https://gateway.marvel.com"

    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders

        manager = Alamofire.SessionManager(configuration: configuration)
    }

    func secureRequest<T,E>(endPoint: String,
                            method: HTTPMethod,
                            parameters: [String : Any]? = nil,
                            encoding: ParameterEncoding = URLEncoding.default,
                            headers: HTTPHeaders? = nil,
                            completion: (APICompletion<T, E>?)) -> Void {
    
        let completeRequest = baseURL  + endPoint

        let secureHeader = [
            "Accept": "application/json",
            "Content-Type": "application/json",
        ]
        
        let timeStamp = Date().stringValue()
        var params: [String: Any] = parameters ?? [:]
        params["apikey"] = APIConstants.kAPIPublicKey
        params["ts"] = timeStamp
        params["hash"] = MD5(string: timeStamp + APIConstants.kAPIPrivateKey + APIConstants.kAPIPublicKey)
        manager.request(completeRequest, method: method, parameters: params, encoding: encoding, headers: secureHeader)
            .responseJSON(completionHandler: { [weak self] response in
                self?.processResponse(response: response, completion: completion)
            })
    }
    
    func MD5(string: String) -> String {
        let data = string.data(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))

        _ = data!.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) in
            return CC_MD5(bytes.baseAddress, CC_LONG(data!.count), &digest)
        }

        return digest.reduce(into: "") { $0 += String(format: "%02x", $1) }
    }
    
    //----------------------------
    // MARK: - Process response
    //----------------------------
    private func processResponse<T,E>(response: DataResponse<Any>, completion: (APICompletion<T, E>?)) -> Void {
                
        guard let jsonValue = response.result.value as? [String: Any] else {
            DispatchQueue.main.async {
                self.checkError(response: response, error: nil, completion: completion)
            }
            return
        }
       
        switch response.result {
        case .success:
            guard let dataJSON = jsonValue["data"] as? [String: Any],
                let resultsJSON = dataJSON["results"],
                let data = try? JSONSerialization.data(withJSONObject: JSONSerialization.isValidJSONObject(resultsJSON) ? resultsJSON : []) else {
                    DispatchQueue.main.async {
                        self.checkError(response: response, error: nil, completion: completion)
                    }
                    return
            }
            do {
                let decodingHelper = try JSONDecoder().decode(DecodingHelper.self, from: data)
                if let decType: Decodable.Type = T.self as? Decodable.Type {
                    let model = try decodingHelper.decode(to: decType)
                    completion?(true, APIResponse(data: model as? T))
                }
                
            } catch {
                completion?(false, nil)
            }
        case .failure (let error):
            DispatchQueue.main.async {
                self.checkError(response: response, error: error, completion: completion)
            }
        }
    }
    
    //----------------------------
    // MARK: - Process ERRORs on request
    //----------------------------
    func checkError<T,E>(response: DataResponse<Any>, error: Error?, completion: (APICompletion<T, E>?)) {
        if let err = error as? URLError {
            completion?(false, APIResponse(error: ErrorResponse(code: err.code.rawValue, status: "Comprueba tu conexión a internet")))
        } else {
            do {
                if let data = response.data {
                    let jsonDecoder = JSONDecoder()
                    let errorResponse = try jsonDecoder.decode(ErrorResponse.self, from: data)

                    completion?(false, APIResponse(error: errorResponse))
                } else {
                    completion?(false, APIResponse(error: ErrorResponse(status: "Ha ocurrido un error")))
                }
            } catch let error {
                completion?(false, APIResponse(error: ErrorResponse(status: error.localizedDescription)))
            }
        }
    }
}
