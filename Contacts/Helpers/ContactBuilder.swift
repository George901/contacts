//
//  ContactBuilder.swift
//  Contacts
//
//  Created by Georgiy Farafonov on 08.09.2020.
//  Copyright © 2020 Georgiy Farafonov. All rights reserved.
//

import UIKit

final class ContactBuilder: NSObject {
    
    private let contact: Contact = Contact()
    
    func with(id: String) -> ContactBuilder {
        contact.id = id
        return self
    }
    
    func with(firstName: String) -> ContactBuilder {
        contact.firstName = firstName
        return self
    }
    
    func with(lastName: String) -> ContactBuilder {
        contact.lastName = lastName
        return self
    }
    
    func with(email: String) -> ContactBuilder {
        contact.email = email
        return self
    }
    
    func with(photoLink: String) -> ContactBuilder {
        contact.photoLink = photoLink
        return self
    }
    
    func build() -> Contact {
        return contact
    }

}
