//
//  HomeViewController.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 23/11/24.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: HomeViewModel
    private var cancellables = Set<AnyCancellable>()
    lazy var sections: [Section] = [
        CarouselSection(onPageChange: { page in
            self.updatePageIndicator(currentPage: page)
        }),
        ListUsersSection(users: [])
    ]
    
    // MARK: - UI Components
    private let loadingView = LoadingView()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LogoBullion")
        imageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 104).isActive = true
        return imageView
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Logout", for: .normal)
        button.titleLabel?.font = .customFont(font: .inter, style: .semibold, size: 12)
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(CarouselItemCollectionViewCell.self, forCellWithReuseIdentifier: CarouselItemCollectionViewCell.identifier)
        collectionView.register(PageIndicatorCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: PageIndicatorCollectionReusableView.identifier)
        collectionView.register(TitleSectionCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleSectionCollectionReusableView.identifier)
        collectionView.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: UserCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var collectionViewLayout: UICollectionViewLayout = {
        var sections = self.sections
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            return sections[sectionIndex].layoutSection()
        }
        layout.register(SectionBackgroundReusableView.self, forDecorationViewOfKind: "background")
        return layout
    }()
    
    private lazy var addUserButton: PrimaryButton = {
        let button = PrimaryButton(title: "Add User")
        button.addTarget(self, action: #selector(addUserButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Life Cyle
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureNavBar()
        setupObserver()
        
        viewModel.getUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.setGradientBackground()
    }
    
    override func viewDidLayoutSubviews() {
        collectionView.contentInset = .init(top: view.safeAreaInsets.top, left: 0, bottom: 0, right: 0)
    }
    
    // MARK: - UI Set Up
    private func configureNavBar() {
        let imageItem = UIBarButtonItem(customView: logoImageView)
        let leftSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        leftSpacer.width = 16
        navigationItem.leftBarButtonItems = [leftSpacer, imageItem]
        
        let logoutButtonItem = UIBarButtonItem(customView: logoutButton)
        let rightSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        rightSpacer.width = 16
        navigationItem.rightBarButtonItems = [rightSpacer, logoutButtonItem]
    }
    
    private func configureViews() {
        view.addSubview(collectionView)
        view.addSubview(addUserButton)
        view.addSubview(loadingView)
        view.bringSubviewToFront(loadingView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            addUserButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            addUserButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            addUserButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            addUserButton.heightAnchor.constraint(equalToConstant: PrimaryButton.defaultHeight),
            
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    // MARK: - Observers
    private func setupObserver() {
        viewModel.navigateToLogin
            .sink { [weak self] isNavigate in
                guard let self = self, isNavigate else { return }
                self.navigationController?.setViewControllers([LoginViewController(viewModel: LoginViewModel())], animated: true)
            }
            .store(in: &cancellables)
        
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
        
        viewModel.users
            .sink { [weak self] users in
                guard let self = self else { return }
                if let index = self.sections.firstIndex(where: { $0 is ListUsersSection }) {
                    self.sections[index] = ListUsersSection(users: users)
                    self.collectionView.reloadSections(IndexSet(integer: index))
                }
            }
            .store(in: &cancellables)
        
        viewModel.userDetail
            .sink { [weak self] user in
                self?.showUserDetailDialog(user: user)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Actions
    @objc private func logoutButtonTapped() {
        Alert.present(
            title: "Logout",
            message: "Are you sure want to logout?",
            actions: .close, .ok(handler: {
                self.viewModel.logout()
            }),
            from: self
        )
    }
    
    @objc func addUserButtonTapped(sender: UIButton!) {
        navigationController?.pushViewController(RegisterViewController(viewModel: RegisterViewModel()), animated: true)
    }
    
    // MARK: - Methods
    private func updatePageIndicator(currentPage: Int) {
        guard let footerView = collectionView.supplementaryView(
            forElementKind: UICollectionView.elementKindSectionFooter,
            at: IndexPath(item: 0, section: 0)
        ) as? PageIndicatorCollectionReusableView else {
            return
        }
        footerView.currentPage(currentPage)
    }
    
    private func showUserDetailDialog(user: User) {
        let detailUserView = DetailUserView()
        let detailDialogVC = DialogViewController(detailUserView)
        detailUserView.setupData(user: user)
        
        detailUserView.didTappedEditButton = { [weak self] in
            detailDialogVC.hide()
            self?.navigationController?.pushViewController(EditUserViewController(viewModel: EditUserViewModel()), animated: true)
        }
        
        detailUserView.didTappedUserImage = { [weak self] in
            guard let photo = user.photo else { return }
            detailDialogVC.dismiss(animated: true)
            let userPhotoView = UserPhotoView()
            let photoDialogVC = DialogViewController(userPhotoView)
            userPhotoView.setImage(image: photo)
            self?.navigationController?.present(photoDialogVC, animated: true)
        }
        
        navigationController?.present(detailDialogVC, animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return sections[indexPath.section].configureCell(collectionView: collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return sections[indexPath.section].configureHeader(collectionView: collectionView, indexPath: indexPath)
        case UICollectionView.elementKindSectionFooter:
            return sections[indexPath.section].configureFooter(collectionView: collectionView, indexPath: indexPath)
        default:
            fatalError("Unexpected element kind")
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.cellForItem(at: indexPath) is UserCollectionViewCell {
            let userId = viewModel.users.value[indexPath.item].id
            viewModel.getUserDetail(id: userId)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == viewModel.users.value.count - 1 {
            if !viewModel.isLoading.value {
                print("fetch more data")
                viewModel.getUsers()
            }
        }
    }
}
