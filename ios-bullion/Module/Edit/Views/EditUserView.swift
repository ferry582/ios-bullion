//
//  EditUserView.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 26/11/24.
//

import UIKit

protocol EditUserViewDelegate: AnyObject {
    func didTapAddUserButton()
}

class EditUserView: UIView {
    
    // MARK: - Properties
    weak var delegate: EditUserViewDelegate?
    
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
        textfield.didTappedTextField = { [weak self] in
            
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
        textfield.didTappedTextField = { [weak self] in
            
        }
        return textfield
    }()
    
    private lazy var updateUserButton: PrimaryButton = {
        let button = PrimaryButton(title: "Update User")
        button.addTarget(self, action: #selector(updateUserButtonTapped), for: .touchUpInside)
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
        [nameTextField, genderSelectionView, dobTextField, emailTextField, phoneNumberTextField, photoProfileTextField].forEach {
            stackView.addArrangedSubview($0)
        }
        addSubview(updateUserButton)
        
        let spacerLayoutGuide = UILayoutGuide()
        addLayoutGuide(spacerLayoutGuide)
        
        NSLayoutConstraint.activate([
            roundedContainerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            roundedContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            roundedContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            roundedContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: roundedContainerView.topAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: roundedContainerView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: roundedContainerView.trailingAnchor, constant: -24),
            
            spacerLayoutGuide.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            spacerLayoutGuide.bottomAnchor.constraint(equalTo: updateUserButton.topAnchor),
            spacerLayoutGuide.heightAnchor.constraint(greaterThanOrEqualToConstant: 24),
            
            updateUserButton.leadingAnchor.constraint(equalTo: roundedContainerView.leadingAnchor, constant: 24),
            updateUserButton.trailingAnchor.constraint(equalTo: roundedContainerView.trailingAnchor, constant: -24),
            updateUserButton.bottomAnchor.constraint(equalTo: roundedContainerView.bottomAnchor, constant: -32),
            updateUserButton.heightAnchor.constraint(equalToConstant: PrimaryButton.defaultHeight),
        ])
    }
    
    // MARK: - Actions
    @objc func updateUserButtonTapped(sender: UIButton!) {
        delegate?.didTapAddUserButton()
    }
}
