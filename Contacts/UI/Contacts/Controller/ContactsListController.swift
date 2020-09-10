//
//  ContactsListController.swift
//  Contacts
//
//  Created by Georgiy Farafonov on 09.09.2020.
//  Copyright © 2020 Georgiy Farafonov. All rights reserved.
//

import UIKit

class ContactsListController: BaseController {
    
    var viewModel: ContactsViewModel!
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"
        setupBindings()
        setupTableView()
        setupBarButton()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupBindings() {
        viewModel.onChange = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(reloadContacts(_:)))
    }
    
    @objc func reloadContacts(_ sender: UIBarButtonItem) {
        viewModel.reloadContactsList { (error) in
            if let err = error {
                print(err)
            }
        }
    }
    
    @IBAction private func updateContacts(_ sender: UIButton) {
        viewModel.updateContacts()
    }
    
}

extension ContactsListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactCell
        cell.setup(contact: viewModel.contacts[indexPath.row])
        return cell
    }
    
    
}

extension ContactsListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteContactAt(index: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showContactDetailsAt(index: indexPath.row)
    }
    
}
