//
//  BaseViewController.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 23/11/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackButtonItem()
        addCenterImage()
    }
    
    private func addCenterImage() {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LogoBullion")
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 130).isActive = true
        navigationItem.titleView = imageView
    }
    
    private func addBackButtonItem() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "BackButton"), for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let backButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backButtonItem
        navigationItem.hidesBackButton = true
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
