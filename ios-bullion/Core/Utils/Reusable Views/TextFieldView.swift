//
//  TextFieldView.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 22/11/24.
//

import UIKit

class TextFieldView: UIView {
    // MARK: - Properties
    var didTappedRightIcon: (() -> Void)?
    private var isEditable = true
    private var isSecureTextField = false
    private var descriptionLabelTopConstraint: NSLayoutConstraint?
    
    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .roboto, style: .medium, size: 14)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .roboto, style: .regular, size: 12)
        label.textColor = UIColor(color: .textFieldDescription)
        label.textAlignment = .left
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textField: PaddedTextField = {
        let textfield = PaddedTextField()
        textfield.textColor = .black
        textfield.font = .customFont(font: .roboto, style: .regular, size: 14)
        textfield.textAlignment = .left
        textfield.backgroundColor = .white
        textfield.clipsToBounds = true
        textfield.layer.cornerRadius = 24
        textfield.layer.borderColor = UIColor(color: .border).cgColor
        textfield.layer.borderWidth = 1
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        textField.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.setGradientColor()
    }
    
    // MARK: - UI Setup
    private func configureViews() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(textField)
        
        descriptionLabelTopConstraint = descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            descriptionLabelTopConstraint!,
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            textField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    // MARK: - Methods
    func configure(title: String, placeholder: String, contentType: UITextContentType? = nil, keyboardType: UIKeyboardType = .default) {
        titleLabel.text = title
        textField.textContentType = contentType
        textField.keyboardType = keyboardType
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(color: .placeholder)]
        )
    }
    
    func secureTextField() {
        isSecureTextField = true
        textField.isSecureTextEntry = true
        setRightIcon(image: UIImage(named: "IconHidePass")!)
    }
    
    func disableInputText() {
        self.isEditable = false
    }
    
    func setRightIcon(image: UIImage) {
        let button = UIButton(type: .custom)
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)
        
        button.setImage(image, for: .normal)
        button.configuration = configuration
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 44)
        button.addTarget(self, action: #selector(rightIconTapped), for: .touchUpInside)
        
        textField.padding = .init(top: 0, left: 16, bottom: 0, right: 56)
        textField.rightView = button
        textField.rightViewMode = .always
    }
    
    func addDescription(with description: String) {
        descriptionLabel.text = description
        descriptionLabel.isHidden = false
        descriptionLabelTopConstraint?.constant = 8
    }
    
    // MARK: - Actions
    @objc func rightIconTapped(target: Any?, action: Selector) {
        if isSecureTextField {
            textField.isSecureTextEntry.toggle()
            let iconName = textField.isSecureTextEntry ? "IconHidePass" : "IconShowPass"
            setRightIcon(image: UIImage(named: iconName)!)
        } else {
            didTappedRightIcon?()
        }
    }
}

extension TextFieldView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return false
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return isEditable
    }
}

class PaddedTextField: UITextField {
    var padding: UIEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
