//
//  JsonParser.swift
//  Contacts
//
//  Created by Georgiy Farafonov on 08.09.2020.
//  Copyright © 2020 Georgiy Farafonov. All rights reserved.
//

import UIKit
import ObjectMapper

enum JsonParserError: Error {
    case wrongDataFormatError
    case parserError
}

class JsonParser: NSObject {
    
    private let json: Any?
    
    init(json: Any?) {
        self.json = json
        super.init()
    }
    
    func parseObject<T: Mappable>(mappable: T.Type, onSuccess: SuccessBlock<T>?, onError: ErrorBlock?) {
        if let data = json as? [String : Any] {
            parseObjectFrom(data: data, onSuccess: onSuccess, onError: onError)
        } else {
            onError?(JsonParserError.wrongDataFormatError)
        }
    }
    
    func parseArray<T: Mappable>(mappable: T.Type, onSuccess: SuccessBlock<[T]>?, onError: ErrorBlock?) {
        if let data = json as? [[String : Any]] {
            parseArrayFrom(data: data, onSuccess: onSuccess, onError: onError)
        } else {
            onError?(JsonParserError.wrongDataFormatError)
        }
    }

    private func parseObjectFrom<T: Mappable>(data: [String : Any], onSuccess: SuccessBlock<T>?, onError: ErrorBlock?) {
        if let parsedObject = Mapper<T>().map(JSON: data) {
            onSuccess?(parsedObject)
        } else {
            onError?(JsonParserError.parserError)
        }
    }
    
    private func parseArrayFrom<T: Mappable>(data: [[String : Any]], onSuccess: SuccessBlock<[T]>?, onError: ErrorBlock?) {
        if let parsedArray = Mapper<T>().mapArray(JSONObject: data) {
            onSuccess?(parsedArray)
        } else {
            onError?(JsonParserError.parserError)
        }
    }
    

}

