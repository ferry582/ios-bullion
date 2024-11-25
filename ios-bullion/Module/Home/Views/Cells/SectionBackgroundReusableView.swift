//
//  SectionBackgroundReusableView.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 25/11/24.
//

import UIKit

class SectionBackgroundReusableView: UICollectionReusableView {
    
    private let roundedContainerView = RoundedContainerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        addSubview(roundedContainerView)
        NSLayoutConstraint.activate([
            roundedContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            roundedContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            roundedContainerView.topAnchor.constraint(equalTo: topAnchor),
            roundedContainerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
