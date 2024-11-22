//
//  TextFieldView.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 22/11/24.
//

import UIKit

class TextFieldView: UIView {
    // MARK: - Properties
    var didTappedTextField: (() -> Void)?
    
    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .roboto, style: .medium, size: 14)
        label.textAlignment = .left
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
    init(title: String, type: UITextContentType? = nil, placeholder: String = "") {
        super.init(frame: .zero)
        configureViews()
        
        titleLabel.text = title
        textField.textContentType = type
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor(color: .placeholder)])
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
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    // MARK: - Methods
    func setKeyboardType(_ type: UIKeyboardType) {
        textField.keyboardType = type
    }
    
    func isSecureTextField(_ isSecure: Bool) {
        textField.isSecureTextEntry = isSecure
    }
    
    func isEditable(_ isEditable: Bool) {
//        textField.isUserInteractionEnabled = isEditable
        textField.isEnabled = isEditable
    }
}

class PaddedTextField: UITextField {
    let padding: UIEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
    
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
