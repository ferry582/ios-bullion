//
//  DetailUserView.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 26/11/24.
//

import UIKit

class DetailUserView: UIView {
    var didTappedEditButton: (() -> Void)?
    
    // MARK: - UI Components
    private let userImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "IconImage")
        iv.contentMode = .scaleAspectFit
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
    
    private let genderInfoView = InfoItemView(title: "Gender", value: "MALE")
    private let phoneNumberInfoView = InfoItemView(title: "Phone Number", value: "082182822828")
    private let dobInfoView = InfoItemView(title: "Date of Birth", value: "14 May 1998")
    private let addressInfoView = InfoItemView(title: "Address", value: "JL Moh Hatta Gg Bunga Emas No.1002 Tanjung Senang, Bandar Lampung")
    
    private lazy var infoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            genderInfoView,
            phoneNumberInfoView,
            dobInfoView,
            addressInfoView
        ])
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var editUserButton: PrimaryButton = {
        let button = PrimaryButton(title: "Add User")
        button.addTarget(self, action: #selector(editUserButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        [userImageView, nameLabel, emailLabel, infoStackView, editUserButton].forEach {
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: topAnchor),
            userImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 10),
            
            emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            
            infoStackView.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            infoStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            infoStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            editUserButton.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 10),
            editUserButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            editUserButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            editUserButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            editUserButton.heightAnchor.constraint(equalToConstant: PrimaryButton.defaultHeight)
        ])
    }
    
    // MARK: - Actions
    @objc private func editUserButtonTapped() {
        didTappedEditButton?()
    }
}

class InfoItemView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .inter, style: .medium, size: 10)
        label.textAlignment = .left
        label.textColor = UIColor(color: .secondaryText)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .inter, style: .medium, size: 12)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(title: String, value: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        valueLabel.text = value
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setText(_ text: String) {
        valueLabel.text = text
    }
}
