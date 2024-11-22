//
//  GenderSelectionVIew.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 22/11/24.
//

import UIKit

enum Gender: String {
    case male = "Male"
    case female = "Female"
}

class GenderSelectionView: UIView {
    
    // MARK: - Properties
    private(set) var selectedGender: Gender? {
        didSet {
            maleButton.isSelected = selectedGender == .male
            femaleButton.isSelected = selectedGender == .female
        }
    }
    
    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Gender"
        label.font = .customFont(font: .inter, style: .regular, size: 12)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var maleButton: UIButton = createGenderButton(title: "Male", action: #selector(maleButtonTapped))
    private lazy var femaleButton: UIButton = createGenderButton(title: "Female", action: #selector(femaleButtonTapped))
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.setGradientColor()
    }
    
    // MARK: - UI Setup
    private func configureViews() {
        addSubview(titleLabel)
        addSubview(maleButton)
        addSubview(femaleButton)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            maleButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            maleButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            maleButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            femaleButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            femaleButton.leadingAnchor.constraint(equalTo: maleButton.trailingAnchor, constant: 24),
            femaleButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func getButtonConfiguration() -> UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
        configuration.imagePlacement = .leading
        configuration.imagePadding = 16
        configuration.baseForegroundColor = .black
        configuration.baseBackgroundColor = .clear
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        return configuration
    }
    
    private func createGenderButton(title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .custom)
        button.configuration = getButtonConfiguration()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .customFont(font: .roboto, style: .regular, size: 14)
        button.setImage(UIImage(named: "CheckedBox"), for: .selected)
        button.setImage(UIImage(named: "UncheckedBox"), for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    // MARK: - Actions
    @objc private func maleButtonTapped() {
        selectedGender = .male
    }
    
    @objc private func femaleButtonTapped() {
        selectedGender = .female
    }
}
