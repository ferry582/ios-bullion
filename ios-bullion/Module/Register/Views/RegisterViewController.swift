//
//  RegisterViewController.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 21/11/24.
//

import UIKit

class RegisterViewController: UIViewController {

    // MARK: - Properties
    private let viewModel: RegisterViewModel
    
    // MARK: - UI Components
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.contentInsetAdjustmentBehavior = .never // ignore the safe area
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var registerView: RegisterView = {
        let view = RegisterView()
        view.onBackButtonTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.setGradientBackground()
        super.viewWillAppear(animated)
    }
    
    // MARK: - UI Set Up
    private func configureViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(registerView)
        
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
        ])
    }
}
