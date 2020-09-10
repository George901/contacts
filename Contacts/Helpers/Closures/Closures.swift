//
//  Closures.swift
//  Contacts
//
//  Created by Georgiy Farafonov on 08.09.2020.
//  Copyright © 2020 Georgiy Farafonov. All rights reserved.
//

import Foundation

typealias SuccessBlock<T> = (T?) -> ()
typealias ErrorBlock = (Error?) -> ()
typealias CompletionBlock = () -> ()
