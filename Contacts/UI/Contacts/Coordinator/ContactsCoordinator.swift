//
//  ContactsCoordinator.swift
//  Contacts
//
//  Created by Georgiy Farafonov on 09.09.2020.
//  Copyright © 2020 Georgiy Farafonov. All rights reserved.
//

import UIKit

class ContactsCoordinator: NSObject, Coordinator {
    
    unowned var parent: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    func startFlow(with initialController: UIViewController) {
        if let contactsVC = initialController as? ContactsListController {
            let viewModel = ContactsListViewModel(api: ContactsApiClient(client: APIClient.shared),
                                                  database: DatabaseClient.shared)
            viewModel.coordinator = self
            contactsVC.viewModel = viewModel
            navigationController.pushViewController(contactsVC, animated: false)
        }
    }
    
    func showContactDetails(contact: Contact) {
        
        let detailsVC = ContactDetailsController.instantiateFromStoryboardNamed("Contacts",
                                                                                storyboardID: "ContactDetailsController")
        let viewModel = ContactDetailedViewModel(contact: contact, database: DatabaseClient.shared)
        viewModel.coordinator = self
        viewModel.onDeleteContact = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
        detailsVC.viewModel = viewModel
        navigationController.pushViewController(detailsVC, animated: true)
    }
    
    func edit(contact: Contact) {
        let editContactVC = EditContactController.instantiateFromStoryboardNamed("Contacts",
                                                                                 storyboardID: "EditContactController")
        let viewModel = ContactEditViewModel(contact: contact,
                                             database: DatabaseClient.shared)
        viewModel.onComplete = {
            editContactVC.dismiss(animated: true, completion: nil)
        }
        editContactVC.viewModel = viewModel
        navigationController.present(editContactVC, animated: true, completion: nil)
    }
    
}
