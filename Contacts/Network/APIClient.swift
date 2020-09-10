//
//  APIClient.swift
//  Contacts
//
//  Created by Georgiy Farafonov on 08.09.2020.
//  Copyright © 2020 Georgiy Farafonov. All rights reserved.
//

import UIKit
import Alamofire

class APIClient: NSObject {
    
    static let shared: APIClient = APIClient()
    
    
    func request(_ path: String,
                 method: HTTPMethod,
                 parameters: [String : Any]?,
                 headers: [String : String]? = nil,
                 encoding: ParameterEncoding = URLEncoding.default,
                 onSuccess: SuccessBlock<[String : Any]>?,
                 onError: ErrorBlock?) {
        
        AF.request(path,
                   method: method,
                   parameters: parameters,
                   encoding: encoding,
                   headers: setup(headers: headers),
                   interceptor: nil,
                   requestModifier: nil)
                  .responseJSON { [unowned self] (response) in
                    self.handle(response: response, onSuccess: onSuccess, onError: onError)
              }
        
    }
    
    private func handle(response: AFDataResponse<Any>, onSuccess: SuccessBlock<[String : Any]>?, onError: ErrorBlock?) {
        switch response.result {
        case .success(let json):
            onSuccess?(json as? [String : Any])
        case .failure(let error):
            onError?(error)
        }
    }

    private func setup(headers: [String : String]?) -> HTTPHeaders? {
        if let headers = headers {
            return HTTPHeaders(headers)
        } else {
            return nil
        }
    }
    
}
