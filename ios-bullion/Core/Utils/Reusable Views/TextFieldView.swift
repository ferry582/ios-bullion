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
    
    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .inter, style: .regular, size: 12)
        label.textAlignment = .left
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .roboto, style: .regular, size: 12)
        label.textColor = UIColor(color: .textFieldDescription)
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()
    
    private let textField: PaddedTextField = {
        let textfield = PaddedTextField()
        textfield.textColor = .black
        textfield.font = .customFont(font: .roboto, style: .regular, size: 14)
        textfield.backgroundColor = .white
        textfield.clipsToBounds = true
        textfield.layer.cornerRadius = 24
        textfield.layer.borderColor = UIColor(color: .border).cgColor
        textfield.layer.borderWidth = 1
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 8
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
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
        stackView.layoutIfNeeded()
        titleLabel.setGradientColor()
    }
    
    // MARK: - UI Setup
    private func configureViews() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(textField)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 48),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    // MARK: - Methods
    func configure(title: String, titleFont: UIFont? = nil, placeholder: String, description: String? = nil, contentType: UITextContentType? = nil, keyboardType: UIKeyboardType = .default, isEditable: Bool = true) {
        titleLabel.text = title
        textField.textContentType = contentType
        textField.keyboardType = keyboardType
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(color: .placeholder)]
        )
        self.isEditable = isEditable
        if let titleFont { titleLabel.font = titleFont }
        if let description {
            descriptionLabel.text = description
            descriptionLabel.isHidden = false
        }
    }
    
    func secureTextField() {
        isSecureTextField = true
        textField.isSecureTextEntry = true
        setRightIcon(image: UIImage(named: "IconHidePass")!)
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
