//
//  ContactsApiClient.swift
//  Contacts
//
//  Created by Georgiy Farafonov on 07.09.2020.
//  Copyright © 2020 Georgiy Farafonov. All rights reserved.
//

import UIKit
import Alamofire

class ContactsApiClient: NSObject, ContactsApi {
    
    private let requestPath = "https://randomuser.me/api"
    private let apiClient: APIClient
    
    init(client: APIClient) {
        self.apiClient = client
        super.init()
    }
    
    func getContacts(onSuccess: SuccessBlock<[Contact]>?, onError: ErrorBlock?) {
        apiClient.request(requestPath,
                          method: .get,
                          parameters: ["results" : 20],
                          onSuccess: { (json) in
                            JsonParser(json: json?["results"]).parseArray(mappable: Contact.self,
                                                              onSuccess: onSuccess,
                                                              onError: onError)
                            
        }, onError: onError)
    }
    
}
