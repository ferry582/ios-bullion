//
//  UserCollectionViewCell.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 25/11/24.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {
    static let identifier = "UserCollectionViewCell"
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "IconImage")
        iv.contentMode = .scaleAspectFit
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 6
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Ghalyatama Ikram Fauzi"
        label.font = .customFont(font: .inter, style: .medium, size: 12)
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "ghalyatama@bullion.com"
        label.font = .customFont(font: .inter, style: .medium, size: 10)
        label.textAlignment = .left
        label.textColor = UIColor(color: .secondaryText)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dobLabel: UILabel = {
        let label = UILabel()
        label.text = "May 14,1998"
        label.font = .customFont(font: .inter, style: .medium, size: 10)
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBg()
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBg() {
        contentView.backgroundColor = .white
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 8
        contentView.layer.applyDropShadow(alpha: 0.2, x: 0, y: 2, blur: 4)
    }
    
    private func configureViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(emailLabel)
        contentView.addSubview(dobLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageView.heightAnchor.constraint(equalToConstant: 32),
            imageView.widthAnchor.constraint(equalToConstant: 32),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18.5),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            
            dobLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dobLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    func configure(user: User) {
        nameLabel.text = user.name
        emailLabel.text = user.email
        dobLabel.text = user.dob?.toFormattedString(format: "MMMM dd, yyyy")
        if let photo = user.photo {
            imageView.image = photo
        }
    }
}
