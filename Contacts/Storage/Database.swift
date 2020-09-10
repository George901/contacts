//
//  Database.swift
//  Contacts
//
//  Created by Georgiy Farafonov on 07.09.2020.
//  Copyright © 2020 Georgiy Farafonov. All rights reserved.
//

import Foundation

protocol Database: NSObjectProtocol {

    func initializeStorage(_ storage: Storage)
    func save(contacts: [Contact])
    func fetchContacts() -> [Contact]
    func add(contact: Contact)
    func remove(contact: Contact)
    func edit(contact: Contact)
    func isEmpty() -> Bool
    func clear() 
    
}
