//
//  EditContactViewModel.swift
//  Contacts
//
//  Created by Georgiy Farafonov on 09.09.2020.
//  Copyright © 2020 Georgiy Farafonov. All rights reserved.
//

import UIKit

protocol EditContactViewModel: NSObjectProtocol {
    
    var contactToEdit: Contact { get set }
    
    func edit(firstName: String)
    func edit(lastName: String)
    func edit(email: String)
    func hasChanges() -> Bool
    func save()
    func cancel()
}

class ContactEditViewModel: NSObject, EditContactViewModel {
    
    var onComplete: CompletionBlock?
    
    var contactToEdit: Contact
    
    private let editedContact: Contact
    private let database: Database
    
    init(contact: Contact, database: Database) {
        self.contactToEdit = contact
        self.database = database
        editedContact = contact.copy() as! Contact
        super.init()
    }
    
    func edit(firstName: String) {
        editedContact.firstName = firstName
    }
    
    func edit(lastName: String) {
        editedContact.lastName = lastName
    }
    
    func edit(email: String) {
        editedContact.email = email
    }
    
    func hasChanges() -> Bool {
        return contactToEdit != editedContact
    }
    
    func save() {
        database.edit(contact: editedContact)
        NotificationCenter.default.post(name: NSNotification.updateContacts, object: nil)
        onComplete?()
    }
    
    func cancel() {
        onComplete?()
    }

}
