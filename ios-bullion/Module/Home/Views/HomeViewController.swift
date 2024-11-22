//
//  HomeViewController.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 23/11/24.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Properties
    private let viewModel: HomeViewModel
    
    // MARK: - UI Components
    
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

        // Do any additional setup after loading the view.
    }

}
