//
//  SplashController.swift
//  Contacts
//
//  Created by Georgiy Farafonov on 07.09.2020.
//  Copyright © 2020 Georgiy Farafonov. All rights reserved.
//

import UIKit

class SplashController: BaseController {

    var viewModel: SplashViewModel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadContactsIfNeeded()
    }

}
