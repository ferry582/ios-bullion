//
//  LoginViewController.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 20/11/24.
//

import UIKit
import Combine

class LoginViewController: UIViewController {

    // MARK: - Properties
    private let viewModel: LoginViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    private lazy var signInButton: PrimaryButton = {
        let button = PrimaryButton(title: "Sign In")
        button.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var addUserButton: PrimaryButton = {
        let button = PrimaryButton(title: "Add new Users")
        button.addTarget(self, action: #selector(addUserButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let roundedContainerView = RoundedContainerView()
    
    private let emailTextField: TextFieldView = {
        let textfield = TextFieldView()
        textfield.configure(title: "Email Address", titleFont: .customFont(font: .roboto, style: .medium, size: 14), placeholder: "Enter email..", contentType: .emailAddress, keyboardType: .emailAddress)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let passwordTextField: TextFieldView = {
        let textfield = TextFieldView()
        textfield.configure(title: "Password", titleFont: .customFont(font: .roboto, style: .medium, size: 14), placeholder: "Enter password..", contentType: .password)
        textfield.secureTextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "LogoBullion")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Life Cyle
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        setupObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.setGradientBackground()
    }
    
    // MARK: - UI Set Up
    private func configureViews() {
        view.addSubview(roundedContainerView)
        roundedContainerView.addSubview(emailTextField)
        roundedContainerView.addSubview(passwordTextField)
        roundedContainerView.addSubview(signInButton)
        roundedContainerView.addSubview(addUserButton)
        view.addSubview(logoImageView)
        
        let spacerLayoutGuide = UILayoutGuide()
        view.addLayoutGuide(spacerLayoutGuide)
        
        NSLayoutConstraint.activate([
            roundedContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            roundedContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            roundedContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: roundedContainerView.topAnchor, constant: 32),
            emailTextField.leadingAnchor.constraint(equalTo: roundedContainerView.leadingAnchor, constant: 24),
            emailTextField.trailingAnchor.constraint(equalTo: roundedContainerView.trailingAnchor, constant: -24),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: roundedContainerView.leadingAnchor, constant: 24),
            passwordTextField.trailingAnchor.constraint(equalTo: roundedContainerView.trailingAnchor, constant: -24),
            
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 52),
            signInButton.leadingAnchor.constraint(equalTo: roundedContainerView.leadingAnchor, constant: 24),
            signInButton.trailingAnchor.constraint(equalTo: roundedContainerView.trailingAnchor, constant: -24),
            signInButton.heightAnchor.constraint(equalToConstant: PrimaryButton.defaultHeight),
            
            addUserButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 16),
            addUserButton.leadingAnchor.constraint(equalTo: roundedContainerView.leadingAnchor, constant: 24),
            addUserButton.trailingAnchor.constraint(equalTo: roundedContainerView.trailingAnchor, constant: -24),
            addUserButton.bottomAnchor.constraint(equalTo: roundedContainerView.safeAreaLayoutGuide.bottomAnchor),
            addUserButton.heightAnchor.constraint(equalToConstant: PrimaryButton.defaultHeight),
            
            spacerLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor),
            spacerLayoutGuide.bottomAnchor.constraint(equalTo: roundedContainerView.topAnchor),
            
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: spacerLayoutGuide.centerYAnchor),
        ])
    }
    
    // MARK: - Observers
    private func setupObserver() {
        viewModel.alertMessage
            .sink { [weak self] message in
                guard let self = self else { return }
                Alert.present(title: nil, message: message, actions: .close, from: self)
            }
            .store(in: &cancellables)
        
        viewModel.navigateToHome
            .sink { [weak self] isNavigate in
                guard let self = self, isNavigate else { return }
                self.navigationController?.setViewControllers([HomeViewController(viewModel: HomeViewModel())], animated: true)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Actions
    @objc func signInButtonTapped(sender: UIButton!) {
        viewModel.login(email: emailTextField.text, password: passwordTextField.text)
    }

    @objc func addUserButtonTapped(sender: UIButton!) {
        let vc = RegisterViewController(viewModel: RegisterViewModel())
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
