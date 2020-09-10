//
//  SplashViewModelClient.swift
//  Contacts
//
//  Created by Georgiy Farafonov on 07.09.2020.
//  Copyright © 2020 Georgiy Farafonov. All rights reserved.
//

import UIKit

protocol SplashViewModel: NSObjectProtocol {
    var onFinishDisplaying: CompletionBlock? {get set}
    init(api: ContactsApi, database: Database)
    func loadContactsIfNeeded()
}

class SplashViewModelClient: NSObject, SplashViewModel {
    
    var onFinishDisplaying: CompletionBlock?
    
    private let api: ContactsApi
    private let database: Database
    
    required init(api: ContactsApi, database: Database) {
        self.api = api
        self.database = database
        super.init()
    }
    
    func loadContactsIfNeeded() {
        if database.isEmpty() {
            api.getContacts(onSuccess: { [weak self] (contacts) in
                if let newContacts = contacts {
                    self?.database.save(contacts: newContacts)
                    self?.onFinishDisplaying?()
                }
            }) { [weak self] (error) in
                if let err = error {
                    print(err)
                    self?.onFinishDisplaying?()
                }
            }
        } else {
            onFinishDisplaying?()
        }
    }

}
