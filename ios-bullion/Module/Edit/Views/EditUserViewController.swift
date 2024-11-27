//
//  EditUserViewController.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 25/11/24.
//

import UIKit
import Combine

protocol EditUserViewControllerDelegate: AnyObject {
    func shoudReloadUsersList()
}

class EditUserViewController: BaseViewController {

    // MARK: - Properties
    private let viewModel: EditUserViewModel
    private var cancellables = Set<AnyCancellable>()
    private let user: User
    weak var delegate: EditUserViewControllerDelegate?
    
    // MARK: - UI Components
    private let loadingView = LoadingView()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.contentInsetAdjustmentBehavior = .never
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var editUserView: EditUserView = {
        let view = EditUserView(user: user)
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Life Cyle
    init(viewModel: EditUserViewModel, user: User) {
        self.viewModel = viewModel
        self.user = user
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
        scrollView.addSubview(editUserView)
        view.addSubview(loadingView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            editUserView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            editUserView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            editUserView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            editUserView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            editUserView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            editUserView.heightAnchor.constraint(greaterThanOrEqualToConstant: view.bounds.height - view.safeAreaInsets.top),
            
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
                editUserView.delegate = nil
                self.delegate?.shoudReloadUsersList()
                self.navigationController?.popViewController(animated: true)
            }
            .store(in: &cancellables)
    }
}

extension EditUserViewController: EditUserViewDelegate {
    func didTapAddUserButton(user: User) {
        guard !viewModel.isLoading.value else { return }
        viewModel.updateUser(user: user)
    }
    
    func didTapUserPhoto() {
        guard let photo = user.photo else { return }
        let userPhotoView = UserPhotoView()
        let photoDialogVC = DialogViewController(userPhotoView)
        userPhotoView.setImage(image: photo)
        self.navigationController?.present(photoDialogVC, animated: true)
    }
}
