//
//  Configurator.swift
//  Contacts
//
//  Created by Georgiy Farafonov on 09.09.2020.
//  Copyright © 2020 Georgiy Farafonov. All rights reserved.
//

import UIKit

class Configurator: NSObject {
    
    static let pathToDatabase: String = {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory,
        .userDomainMask,
        true)[0] + "/contactsDb.sqlite3"
    }()

}
