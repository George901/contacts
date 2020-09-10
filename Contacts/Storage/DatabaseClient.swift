//
//  DatabaseClient.swift
//  Contacts
//
//  Created by Georgiy Farafonov on 07.09.2020.
//  Copyright © 2020 Georgiy Farafonov. All rights reserved.
//

import UIKit

final class DatabaseClient: NSObject, Database {

    static let shared: DatabaseClient = DatabaseClient()
    
    private var storage: Storage!
    
    func initializeStorage(_ storage: Storage) {
        self.storage = storage
        do {
            try self.storage.createContactsTableIfNeeded()
        } catch let error {
            print(error)
        }
    }
    
    func fetchContacts() -> [Contact] {
        do {
            return try storage.readContacts()
        } catch let error {
            print(error)
            return []
        }
    }
    
    func add(contact: Contact) {
        do {
            try storage.insert(contact: contact)
        } catch let error {
            print(error)
        }
    }
    
    func remove(contact: Contact) {
        do {
            try storage.delete(contact: contact)
        } catch let error {
            print(error)
        }
    }
    
    func edit(contact: Contact) {
        do {
            try storage.update(contact: contact)
        } catch let error {
            print(error)
        }
    }
    
    func isEmpty() -> Bool {
        return storage.isEmpty()
    }
    
    func save(contacts: [Contact]) {
        contacts.forEach { [unowned self] (contact) in
            self.add(contact: contact)
        }
    }
    
    func clear() {
        do {
            try storage.clear()
        } catch let error {
            print(error)
        }
    }
    
}
