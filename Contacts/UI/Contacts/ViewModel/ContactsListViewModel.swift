//
//  ContactsListViewModel.swift
//  Contacts
//
//  Created by Georgiy Farafonov on 09.09.2020.
//  Copyright © 2020 Georgiy Farafonov. All rights reserved.
//

import UIKit

protocol ContactsViewModel {
    
    var contacts: [Contact] { get set }
    var onChange: CompletionBlock? { get set }
    
    func updateContacts()
    func reloadContactsList(onError: ErrorBlock?)
    func showContactDetailsAt(index: Int)
    func deleteContactAt(index: Int)
    
}

class ContactsListViewModel: NSObject, ContactsViewModel {
    
    var onChange: CompletionBlock?
    var coordinator: ContactsCoordinator!
    
    var contacts: [Contact] = [] {
        didSet {
            onChange?()
        }
    }
    
    private let api: ContactsApi
    private let database: Database
    
    init(api: ContactsApi, database: Database) {
        self.api = api
        self.database = database
        super.init()
        getContacts()
        subscribeForNotifications()
    }
    
    func updateContacts() {
        getContacts()
    }
    
    func reloadContactsList(onError: ErrorBlock?) {
        database.clear()
        api.getContacts(onSuccess: { [unowned self] (fetchedContacts) in
            if let newContacts = fetchedContacts {
                newContacts.forEach { (contact) in
                    self.database.add(contact: contact)
                }
                self.updateContacts()
            }
        }, onError: onError)
    }
    
    func showContactDetailsAt(index: Int) {
        coordinator.showContactDetails(contact: contacts[index])
    }
    
    func deleteContactAt(index: Int) {
        database.remove(contact: contacts[index])
        contacts.remove(at: index)
    }
    
    private func getContacts() {
        contacts = database.fetchContacts()
    }
    
    private func subscribeForNotifications() {
        NotificationCenter.default.addObserver(forName: NSNotification.updateContacts, object: nil, queue: nil) { [weak self] (_) in
            self?.updateContacts()
        }
    }
    
}
