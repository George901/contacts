//
//  ContactDetailsController.swift
//  Contacts
//
//  Created by Georgiy Farafonov on 09.09.2020.
//  Copyright © 2020 Georgiy Farafonov. All rights reserved.
//

import UIKit
import SDWebImage

class ContactDetailsController: BaseController {
    
    var viewModel: ContactDetailsViewModel!
    
    @IBOutlet private weak var contactImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var lastNameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        addBarButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    private func setupBindings() {
        viewModel.onChange = { [weak self] in
            self?.setupUI()
        }
    }
    
    private func addBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                                                  target: self,
                                                                                  action: #selector(editButtonPressed(_:)))
    }
    
    private func setupUI() {
        contactImageView.sd_setImage(with: URL(string: viewModel.contact.photoLink), completed: nil)
        nameLabel.text = viewModel.contact.firstName
        lastNameLabel.text = viewModel.contact.lastName
        emailLabel.text = viewModel.contact.email
    }
    
    @IBAction private func editButtonPressed(_ sender: UIBarButtonItem) {
        viewModel.editContact()
    }
    
    @IBAction private func deleteButtonPressed(_ sender: UIButton) {
           viewModel.deleteContact()
    }

}
