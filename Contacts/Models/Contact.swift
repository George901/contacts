//
//  Contact.swift
//  Contacts
//
//  Created by Georgiy Farafonov on 07.09.2020.
//  Copyright © 2020 Georgiy Farafonov. All rights reserved.
//

import UIKit
import ObjectMapper

class Contact: NSObject, Mappable, NSCopying {
    
    var id: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var photoLink: String = ""
    var email: String = ""
    
    required init?(map: Map) {}
    
    override init() {
        super.init()
    }
    
    func mapping(map: Map) {
        firstName <- map["name.first"]
        lastName <- map["name.last"]
        email   <- map["email"]
        photoLink <- map["picture.medium"]
        id = UUID().uuidString
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let otherContact = object as? Contact {
            return id == otherContact.id
                && firstName == otherContact.firstName
                && lastName == otherContact.lastName
                && email == otherContact.email
        } else {
            return false
        }
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return ContactBuilder()
            .with(id: id)
            .with(email: email)
            .with(lastName: lastName)
            .with(firstName: firstName)
            .with(photoLink: photoLink)
            .build()
      }
    
}
