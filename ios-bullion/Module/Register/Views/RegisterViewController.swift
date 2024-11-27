//
//  RegisterViewController.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 21/11/24.
//

import UIKit
import Combine
import PhotosUI

class RegisterViewController: BaseViewController {
    
    // MARK: - Properties
    private let viewModel: RegisterViewModel
    private var cancellables = Set<AnyCancellable>()
    private var selectedImage: UIImage?
    
    // MARK: - UI Components
    private let loadingView = LoadingView()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.contentInsetAdjustmentBehavior = .never
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var registerView: RegisterView = {
        let view = RegisterView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Life Cyle
    init(viewModel: RegisterViewModel) {
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
        view.addSubview(scrollView)
        scrollView.addSubview(registerView)
        view.addSubview(loadingView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            registerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            registerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            registerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            registerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            registerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
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
        
        viewModel.isLoading
            .sink { [weak self] isLoading in
                self?.loadingView.isLoading(isLoading)
            }
            .store(in: &cancellables)
        
        viewModel.dismissController
            .sink { [weak self] isDismiss in
                guard let self = self, isDismiss else { return }
                registerView.delegate = nil
                self.navigationController?.popViewController(animated: true)
            }
            .store(in: &cancellables)
    }
}

extension RegisterViewController: RegisterViewDelegate {
    func didTapAddUserButton(userData: inout User, password: String, confirmPassword: String) {
        guard !viewModel.isLoading.value else { return }
        userData.photo = selectedImage
        viewModel.register(user: userData, photo: selectedImage, password: password, confirmPassword: confirmPassword)
    }
    
    func showImagePicker() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
}

extension RegisterViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        guard let result = results.first else {
            DispatchQueue.main.async {
                picker.dismiss(animated: true, completion: nil)
            }
            return
        }
        
        result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (object, error) in
            if let image = object as? UIImage {
                self?.selectedImage = image
            }
            
            if result.itemProvider.hasItemConformingToTypeIdentifier(UTType.image.identifier) {
                result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { (url, error) in
                    if let url = url {
                        DispatchQueue.main.async {
                            self?.registerView.setPhotoTextFieldDetails(filename: url.lastPathComponent)
                        }
                    }
                }
            }
        }
        
        DispatchQueue.main.async {
            picker.dismiss(animated: true, completion: nil)
        }
    }
}
