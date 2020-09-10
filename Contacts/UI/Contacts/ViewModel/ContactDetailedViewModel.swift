//
//  ContactDetailsViewModel.swift
//  Contacts
//
//  Created by Georgiy Farafonov on 09.09.2020.
//  Copyright © 2020 Georgiy Farafonov. All rights reserved.
//

import UIKit

protocol ContactDetailsViewModel {
    
    var contact: Contact { get set }
    var onChange: CompletionBlock? { get set }
    
    func deleteContact()
    func editContact()
    
}

class ContactDetailedViewModel: NSObject, ContactDetailsViewModel {
    
    var contact: Contact {
        didSet {
            onChange?()
        }
    }
    
    var coordinator: ContactsCoordinator!
    let database: Database
    var onDeleteContact: CompletionBlock?
    var onChange: CompletionBlock?
    
    
    init(contact: Contact, database: Database) {
        self.contact = contact
        self.database = database
        super.init()
        subscribeForNotifications()
    }
    
    func deleteContact() {
        database.remove(contact: contact)
        onDeleteContact?()
        NotificationCenter.default.post(name: NSNotification.updateContacts, object: nil)
    }
    
    func editContact() {
        coordinator.edit(contact: contact)
    }
    
    private func subscribeForNotifications() {
        NotificationCenter.default.addObserver(forName: NSNotification.updateContacts, object: nil, queue: nil) { [weak self] (_) in
            self?.reloadContact()
        }
    }
    
    private func reloadContact() {
        guard let newContact = database.fetchContacts().first(where: {$0.id == contact.id}) else { return }
        contact = newContact
    }

}
