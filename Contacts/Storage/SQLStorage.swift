//
//  SQLStorage.swift
//  Contacts
//
//  Created by Georgiy Farafonov on 07.09.2020.
//  Copyright © 2020 Georgiy Farafonov. All rights reserved.
//

import UIKit
import SQLite

enum SQLError: Error {
    case databaseDoesNotExist
    case entityNotFound
}

final class SQLStorage: NSObject, Storage {
    
    private var database: Connection?
    private let table: Table = Table("contacts")
    private let id = Expression<String>("Identifier")
    private let firstName = Expression<String>("FirstName")
    private let lastName = Expression<String>("LastName")
    private let email = Expression<String>("Email")
    private let photoLink = Expression<String>("PhotoLink")
    
    required init(path: String) {
        do {
            self.database = try Connection(path)
        } catch let err {
            print(err)
        }
    }
    
    func createContactsTableIfNeeded() throws {
        guard let db = database else { throw SQLError.databaseDoesNotExist }
        try db.run(table.create(ifNotExists: true) { builder in
            builder.column(id, primaryKey: true)
            builder.column(email, unique: true)
            builder.column(firstName)
            builder.column(lastName)
            builder.column(photoLink)
        })
    }
    
    func isEmpty() -> Bool {
        return (try? (database?.scalar(table.count) ?? 0) == 0) ?? true
    }
    
    func insert(contact: Contact) throws {
        guard let db = database else { throw SQLError.databaseDoesNotExist }
        let insertAction = table.insert(id <- contact.id,
                                        email <- contact.email,
                                        firstName <- contact.firstName,
                                        lastName <- contact.lastName,
                                        photoLink <- contact.photoLink)
        let rowId = try db.run(insertAction)
        print("SUCCESSFULLY INSERTED ROW: \(rowId)")
    }
    
    func readContacts() throws -> [Contact] {
        guard let db = database else { return [] }
        var contacts: [Contact] = []
        for contact in try db.prepare(table) {
            contacts.append(ContactBuilder()
                .with(id: contact[id])
                .with(email: contact[email])
                .with(firstName: contact[firstName])
                .with(lastName: contact[lastName])
                .with(photoLink: contact[photoLink])
                .build())
        }
        print("SUCCESSFULLY FETCHED CONTACTS: \(contacts.count)")
        return contacts
    }
    
    func update(contact: Contact) throws {
        guard let db = database else { throw SQLError.databaseDoesNotExist }
        let entityToUpdate = table.filter(id == contact.id)
        let allContacts = try readContacts()
        guard let oldContact = allContacts.first(where: {$0.id == contact.id}) else { throw SQLError.entityNotFound }
        
        try db.run(entityToUpdate.update(email <- email.replace(oldContact.email,
                                                                with: contact.email),
                                         firstName <- firstName.replace(oldContact.firstName,
                                                                        with: contact.firstName),
                                         lastName <- lastName.replace(oldContact.lastName,
                                                                      with: contact.lastName)))
        print("SUCCESSFULLY UPDATED CONTACT: \(contact.id)")
        
    }
    
    func delete(contact: Contact) throws {
        guard let db = database else { throw SQLError.databaseDoesNotExist }
        let entityToDelete = table.filter(id == contact.id)
        try db.run(entityToDelete.delete())
        print("SUCCESSFULLY DELETED CONTACT: \(contact.id)")
    }
    
    func clear() throws {
        guard let db = database else { throw SQLError.databaseDoesNotExist }
        try db.run(table.delete())
        print("DATABASE HAS BEEN CLEARED")
    }
    
    
}
