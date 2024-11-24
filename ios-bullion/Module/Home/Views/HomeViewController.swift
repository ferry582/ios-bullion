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
        CarouselSection()
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
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.register(CarouselItemCollectionViewCell.self, forCellWithReuseIdentifier: CarouselItemCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var collectionViewLayout: UICollectionViewLayout = {
        var sections = self.sections
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            return sections[sectionIndex].layoutSection()
        }
        return layout
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
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
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
}
