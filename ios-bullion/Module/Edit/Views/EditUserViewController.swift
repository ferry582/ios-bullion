//
//  EditUserViewController.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 25/11/24.
//

import UIKit

class EditUserViewController: BaseViewController {

    // MARK: - Properties
    private let viewModel: EditUserViewModel
    
    // MARK: - UI Components
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.contentInsetAdjustmentBehavior = .never
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var editUserView: EditUserView = {
        let view = EditUserView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Life Cyle
    init(viewModel: EditUserViewModel) {
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
        super.viewWillAppear(animated)
        view.setGradientBackground()
    }

    // MARK: - UI Set Up
    private func configureViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(editUserView)
        
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
            editUserView.heightAnchor.constraint(greaterThanOrEqualToConstant: view.bounds.height - view.safeAreaInsets.top)
        ])
    }

}

extension EditUserViewController: EditUserViewDelegate {
    func didTapAddUserButton() {
        
    }
}
