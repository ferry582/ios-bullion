//
//  LoadingView.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 25/11/24.
//

import UIKit

class LoadingView: UIView {
    
    // MARK: UI Components
    private let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.style = .large
        activity.startAnimating()
        activity.color = .white
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 0, alpha: 0.6)
        layer.cornerRadius = 20
        clipsToBounds = true
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureViews()
    }
    
    // MARK: UI Setup
    private func configureViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func isLoading(_ isLoading: Bool) {
        self.isHidden = !isLoading
    }
}
