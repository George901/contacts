//
//  ContactCell.swift
//  Contacts
//
//  Created by Georgiy Farafonov on 09.09.2020.
//  Copyright © 2020 Georgiy Farafonov. All rights reserved.
//

import UIKit
import SDWebImage

class ContactCell: UITableViewCell {
    
    @IBOutlet private weak var contactImageView: UIImageView!
    @IBOutlet private weak var firstNameLabel: UILabel!
    @IBOutlet private weak var lastNameLabel: UILabel!
    
    func setup(contact: Contact) {
        contactImageView.sd_setImage(with: URL(string: contact.photoLink), completed: nil)
        firstNameLabel.text = contact.firstName
        lastNameLabel.text = contact.lastName
    }

}
