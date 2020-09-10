//
//  Storyboarded.swift
//  Contacts
//
//  Created by Georgiy Farafonov on 07.09.2020.
//  Copyright © 2020 Georgiy Farafonov. All rights reserved.
//

import UIKit

protocol Storyboarded: NSObjectProtocol {
    static func instantiateFromStoryboardNamed(_ name: String, storyboardID: String) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiateFromStoryboardNamed(_ name: String, storyboardID: String) -> Self {
        return UIStoryboard(name: name, bundle: Bundle.main).instantiateViewController(identifier: storyboardID)
    }
}
 
