//
//  TitleSectionCollectionReusableView.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 25/11/24.
//

import UIKit

class TitleSectionCollectionReusableView: UICollectionReusableView {
    static let identifier = "TitleSectionCollectionReusableView"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .roboto, style: .medium, size: 14)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.setGradientColor()
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
