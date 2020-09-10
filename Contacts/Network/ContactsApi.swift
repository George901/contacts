//
//  ContactsApi.swift
//  Contacts
//
//  Created by Georgiy Farafonov on 07.09.2020.
//  Copyright © 2020 Georgiy Farafonov. All rights reserved.
//

import Foundation

protocol ContactsApi: NSObjectProtocol {
    func getContacts(onSuccess: SuccessBlock<[Contact]>?, onError: ErrorBlock?)
}
