//
//  RoundedContainerView.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 22/11/24.
//

import UIKit

class RoundedContainerView: UIView {
    
    init(backgroundColor: UIColor = UIColor(color: .background), cornerRadius: CGFloat = 24) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        configureView(cornerRadius: cornerRadius)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView(cornerRadius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        translatesAutoresizingMaskIntoConstraints = false
    }
}
