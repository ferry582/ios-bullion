//
//  UserPhotoView.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 26/11/24.
//

import UIKit

class UserPhotoView: UIView {

    // MARK: - UI Components
    private lazy var userImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "IconImage")
        iv.contentMode = .scaleAspectFit
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 12
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Set Up
    private func configureViews() {
        addSubview(userImageView)
        
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            userImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            userImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            userImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            userImageView.heightAnchor.constraint(equalToConstant: 150),
            userImageView.widthAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    func setImage(image: UIImage) {
        userImageView.image = image
    }
}
