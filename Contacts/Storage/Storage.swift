//
//  Storage.swift
//  Contacts
//
//  Created by Georgiy Farafonov on 07.09.2020.
//  Copyright © 2020 Georgiy Farafonov. All rights reserved.
//

import Foundation

protocol Storage: NSObjectProtocol {
    
    init(path: String)
    func isEmpty() -> Bool
    func createContactsTableIfNeeded() throws
    func readContacts() throws -> [Contact]
    func insert(contact: Contact) throws
    func update(contact: Contact) throws
    func delete(contact: Contact) throws
    func clear() throws
    
}
