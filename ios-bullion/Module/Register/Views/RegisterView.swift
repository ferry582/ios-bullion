//
//  RegisterView.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 22/11/24.
//

import UIKit

class RegisterView: UIView {
    
    // MARK: - Properties
    var onBackButtonTapped: (() -> Void)?
    
    // MARK: - UI Components
    private lazy var topBarView: TopBarView = {
        let view = TopBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.onBackButtonTapped = { [weak self] in
            self?.onBackButtonTapped?()
        }
        return view
    }()
    
    private let roundedContainerView = RoundedContainerView()
    
    private let nameTextField: TextFieldView = {
        let textfield = TextFieldView(title: "Name", type: .name, placeholder: "Enter name..")
        textfield.setKeyboardType(.default)
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
        addSubview(topBarView)
        addSubview(roundedContainerView)
        
        NSLayoutConstraint.activate([
            topBarView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            topBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            roundedContainerView.topAnchor.constraint(equalTo: topBarView.bottomAnchor),
            roundedContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            roundedContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            roundedContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        roundedContainerView.addSubview(nameTextField)
        roundedContainerView.addSubview(addUserButton)

        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: roundedContainerView.topAnchor, constant: 32),
            nameTextField.leadingAnchor.constraint(equalTo: roundedContainerView.leadingAnchor, constant: 24),
            nameTextField.trailingAnchor.constraint(equalTo: roundedContainerView.trailingAnchor, constant: -24),
            
            addUserButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 24),
            addUserButton.leadingAnchor.constraint(equalTo: roundedContainerView.leadingAnchor, constant: 24),
            addUserButton.trailingAnchor.constraint(equalTo: roundedContainerView.trailingAnchor, constant: -24),
            addUserButton.bottomAnchor.constraint(equalTo: roundedContainerView.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            addUserButton.heightAnchor.constraint(equalToConstant: PrimaryButton.defaultHeight),
        ])
    }
    
    // MARK: - Actions
    @objc func addUserButtonTapped(sender: UIButton!) {
        
    }
}
