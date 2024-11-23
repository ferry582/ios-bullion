//
//  RegisterView.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 22/11/24.
//

import UIKit

protocol RegisterViewDelegate: AnyObject {
    func didTapBackButton()
    func didTapAddUserButton()
}

class RegisterView: UIView {
    
    // MARK: - Properties
    weak var delegate: RegisterViewDelegate?
    
    // MARK: - UI Components
    private let roundedContainerView = RoundedContainerView()
    
    private let nameTextField: TextFieldView = {
        let textfield = TextFieldView()
        textfield.configure(title: "Name", placeholder: "Enter name..", contentType: .name)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let genderSelectionView: GenderSelectionView = {
        let view = GenderSelectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dobTextField: TextFieldView = {
        let textfield = TextFieldView()
        textfield.configure(title: "Date of Birth", placeholder: "Select date", contentType: .birthdateDay, isEditable: false)
        textfield.setRightIcon(image: UIImage(named: "IconCalendar")!)
        textfield.didTappedRightIcon = { [weak self] in
            
        }
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let emailTextField: TextFieldView = {
        let textfield = TextFieldView()
        textfield.configure(title: "Email Address", placeholder: "Enter email..", contentType: .emailAddress, keyboardType: .emailAddress)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let phoneNumberTextField: TextFieldView = {
        let textfield = TextFieldView()
        textfield.configure(title: "Phone Number", placeholder: "Enter phone number..", contentType: .telephoneNumber, keyboardType: .phonePad)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var photoProfileTextField: TextFieldView = {
        let textfield = TextFieldView()
        textfield.configure(title: "Photo Profile", placeholder: "Select photo", isEditable: false)
        textfield.setRightIcon(image: UIImage(named: "IconLink")!)
        textfield.didTappedRightIcon = { [weak self] in
            
        }
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let passwordTextField: TextFieldView = {
        let textfield = TextFieldView()
        textfield.configure(title: "Password", placeholder: "Enter password..", description: "Min 8 Char | Min 1 Capital and Number", contentType: .password)
        textfield.secureTextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let confirmPasswordTextField: TextFieldView = {
        let textfield = TextFieldView()
        textfield.configure(title: "Confirm Password", placeholder: "Re-enter password..", description: "Make sure the password matches", contentType: .password)
        textfield.secureTextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var addUserButton: PrimaryButton = {
        let button = PrimaryButton(title: "Add User")
        button.addTarget(self, action: #selector(addUserButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Set Up
    private func configureViews() {
        addSubview(roundedContainerView)
        [nameTextField, genderSelectionView, dobTextField, emailTextField, phoneNumberTextField, photoProfileTextField, passwordTextField, confirmPasswordTextField, addUserButton].forEach {
            roundedContainerView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            roundedContainerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            roundedContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            roundedContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            roundedContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: roundedContainerView.topAnchor, constant: 32),
            nameTextField.leadingAnchor.constraint(equalTo: roundedContainerView.leadingAnchor, constant: 24),
            nameTextField.trailingAnchor.constraint(equalTo: roundedContainerView.trailingAnchor, constant: -24),
            
            genderSelectionView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            genderSelectionView.leadingAnchor.constraint(equalTo: roundedContainerView.leadingAnchor, constant: 24),
            genderSelectionView.trailingAnchor.constraint(equalTo: roundedContainerView.trailingAnchor, constant: -24),
            
            dobTextField.topAnchor.constraint(equalTo: genderSelectionView.bottomAnchor, constant: 16),
            dobTextField.leadingAnchor.constraint(equalTo: roundedContainerView.leadingAnchor, constant: 24),
            dobTextField.trailingAnchor.constraint(equalTo: roundedContainerView.trailingAnchor, constant: -24),
            
            emailTextField.topAnchor.constraint(equalTo: dobTextField.bottomAnchor, constant: 16),
            emailTextField.leadingAnchor.constraint(equalTo: roundedContainerView.leadingAnchor, constant: 24),
            emailTextField.trailingAnchor.constraint(equalTo: roundedContainerView.trailingAnchor, constant: -24),
            
            phoneNumberTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: roundedContainerView.leadingAnchor, constant: 24),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: roundedContainerView.trailingAnchor, constant: -24),
            
            photoProfileTextField.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 16),
            photoProfileTextField.leadingAnchor.constraint(equalTo: roundedContainerView.leadingAnchor, constant: 24),
            photoProfileTextField.trailingAnchor.constraint(equalTo: roundedContainerView.trailingAnchor, constant: -24),
            
            passwordTextField.topAnchor.constraint(equalTo: photoProfileTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: roundedContainerView.leadingAnchor, constant: 24),
            passwordTextField.trailingAnchor.constraint(equalTo: roundedContainerView.trailingAnchor, constant: -24),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: roundedContainerView.leadingAnchor, constant: 24),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: roundedContainerView.trailingAnchor, constant: -24),
            
            addUserButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 24),
            addUserButton.leadingAnchor.constraint(equalTo: roundedContainerView.leadingAnchor, constant: 24),
            addUserButton.trailingAnchor.constraint(equalTo: roundedContainerView.trailingAnchor, constant: -24),
            addUserButton.bottomAnchor.constraint(equalTo: roundedContainerView.bottomAnchor, constant: -32),
            addUserButton.heightAnchor.constraint(equalToConstant: PrimaryButton.defaultHeight),
        ])
    }
    
    // MARK: - Actions
    @objc func addUserButtonTapped(sender: UIButton!) {
        delegate?.didTapAddUserButton()
    }
}
