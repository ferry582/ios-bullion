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
    private let genderSelectionView = GenderSelectionView()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 16
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let nameTextField: TextFieldView = {
        let textfield = TextFieldView()
        textfield.configure(title: "Name", placeholder: "Enter name..", contentType: .name)
        return textfield
    }()
    
    private lazy var dobTextField: TextFieldView = {
        let textfield = TextFieldView()
        textfield.configure(title: "Date of Birth", placeholder: "Select date", contentType: .birthdateDay, isEditable: false)
        textfield.setRightIcon(image: UIImage(named: "IconCalendar")!)
        textfield.didTappedRightIcon = { [weak self] in
            
        }
        return textfield
    }()
    
    private let emailTextField: TextFieldView = {
        let textfield = TextFieldView()
        textfield.configure(title: "Email Address", placeholder: "Enter email..", contentType: .emailAddress, keyboardType: .emailAddress)
        return textfield
    }()
    
    private let phoneNumberTextField: TextFieldView = {
        let textfield = TextFieldView()
        textfield.configure(title: "Phone Number", placeholder: "Enter phone number..", contentType: .telephoneNumber, keyboardType: .phonePad)
        return textfield
    }()
    
    private lazy var photoProfileTextField: TextFieldView = {
        let textfield = TextFieldView()
        textfield.configure(title: "Photo Profile", placeholder: "Select photo", isEditable: false)
        textfield.setRightIcon(image: UIImage(named: "IconLink")!)
        textfield.didTappedRightIcon = { [weak self] in
            
        }
        return textfield
    }()
    
    private let passwordTextField: TextFieldView = {
        let textfield = TextFieldView()
        textfield.configure(title: "Password", placeholder: "Enter password..", description: "Min 8 Char | Min 1 Capital and Number", contentType: .password)
        textfield.secureTextField()
        return textfield
    }()
    
    private let confirmPasswordTextField: TextFieldView = {
        let textfield = TextFieldView()
        textfield.configure(title: "Confirm Password", placeholder: "Re-enter password..", description: "Make sure the password matches", contentType: .password)
        textfield.secureTextField()
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
        addSubview(stackView)
        [nameTextField, genderSelectionView, dobTextField, emailTextField, phoneNumberTextField, photoProfileTextField, passwordTextField, confirmPasswordTextField].forEach {
            stackView.addArrangedSubview($0)
        }
        addSubview(addUserButton)
        
        NSLayoutConstraint.activate([
            roundedContainerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            roundedContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            roundedContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            roundedContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: roundedContainerView.topAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: roundedContainerView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: roundedContainerView.trailingAnchor, constant: -24),
            
            addUserButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 24),
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
