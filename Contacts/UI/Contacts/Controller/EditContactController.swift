//
//  EditContactController.swift
//  Contacts
//
//  Created by Georgiy Farafonov on 09.09.2020.
//  Copyright © 2020 Georgiy Farafonov. All rights reserved.
//

import UIKit

class EditContactController: BaseController {
    
    var viewModel: EditContactViewModel!
    
    @IBOutlet private weak var firstNameTextField: UITextField!
    @IBOutlet private weak var lastNameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var editButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTextFields()
    }
    
    private func setupUI() {
        firstNameTextField.text = viewModel.contactToEdit.firstName
        lastNameTextField.text = viewModel.contactToEdit.lastName
        emailTextField.text = viewModel.contactToEdit.email
        editButton.isEnabled = false
    }
    
    private func setupTextFields() {
        firstNameTextField.placeholder = "First name"
        lastNameTextField.placeholder = "Last name"
        emailTextField.placeholder = "Email"
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
    }
    
    private func changeButtonState() {
        editButton.isEnabled = viewModel.hasChanges()
    }
    
    @IBAction private func firstNameTextFieldEditingChanged(_ sender: UITextField) {
        viewModel.edit(firstName: sender.text ?? "")
        changeButtonState()
    }
    
    @IBAction private func lastNameTextFieldEditingChanged(_ sender: UITextField) {
        viewModel.edit(lastName: sender.text ?? "")
        changeButtonState()
    }
    
    @IBAction private func emailTextFieldEditingChanged(_ sender: UITextField) {
        viewModel.edit(email: sender.text ?? "")
        changeButtonState()
    }
    
    @IBAction private func doneButtonPressed(_ sender: UIButton) {
        viewModel.save()
    }
    
    @IBAction private func cancelButtonPressed(_ sender: UIButton) {
        viewModel.cancel()
    }
    
}

extension EditContactController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}


