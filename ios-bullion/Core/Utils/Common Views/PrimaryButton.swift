//
//  PrimaryButton.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 20/11/24.
//

import UIKit

class PrimaryButton: UIButton {
    static let defaultHeight: CGFloat = 47
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    convenience init(title: String) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
    
    private func configureViews() {
        backgroundColor = UIColor(color: .blue)
        titleLabel?.font = .customFont(font: .inter, style: .medium, size: 12)
        setTitleColor(.white, for: .normal)
    }
}
