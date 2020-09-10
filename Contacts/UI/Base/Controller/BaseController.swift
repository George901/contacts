//
//  BaseController.swift
//  Contacts
//
//  Created by Georgiy Farafonov on 08.09.2020.
//  Copyright © 2020 Georgiy Farafonov. All rights reserved.
//

import UIKit

class BaseController: UIViewController, Storyboarded {
    
    deinit {
        #if DEBUG
        print("-----\(self) - DEINIT-----")
        #endif
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
