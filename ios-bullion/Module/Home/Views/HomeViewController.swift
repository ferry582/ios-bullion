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
        ListUsersSection(numberOfItems: 10)
    ]
   
    // MARK: - UI Components
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
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            addUserButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            addUserButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            addUserButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            addUserButton.heightAnchor.constraint(equalToConstant: PrimaryButton.defaultHeight)
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
    
    private func updatePageIndicator(currentPage: Int) {
        guard let footerView = collectionView.supplementaryView(
            forElementKind: UICollectionView.elementKindSectionFooter,
            at: IndexPath(item: 0, section: 0)
        ) as? PageIndicatorCollectionReusableView else {
            return
        }
        footerView.currentPage(currentPage)
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
