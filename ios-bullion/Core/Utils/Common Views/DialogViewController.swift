//
//  DetailUserDialogViewController.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 26/11/24.
//

import UIKit

class DialogViewController: UIViewController {
    private lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.3
        view.frame = self.view.frame
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped)))
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "IconClose"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contentView: UIView
    
    public init(_ contentView: UIView) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        
        DispatchQueue.main.async {
            self.showAnimation()
        }
    }
    
    private func configureViews() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(dimmedView)
        view.addSubview(cardView)
        cardView.addSubview(closeButton)
        cardView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            closeButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            closeButton.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            closeButton.widthAnchor.constraint(equalToConstant: 12),
            closeButton.heightAnchor.constraint(equalToConstant: 12),
            
            contentView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 10),
            contentView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            contentView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),
        ])
    }
    
    private func showAnimation() {
        dimmedView.alpha = 0
        cardView.transform = .init(translationX: 0, y: view.frame.height)
        UIView.animate(withDuration: 0.3) {
            self.dimmedView.alpha = 0.3
            self.cardView.transform = .init(translationX: 0, y: 0)
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.3) {
            self.dimmedView.alpha = 0.0
            self.cardView.transform = .init(translationX: 0, y: self.view.frame.height)
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
    
    @objc private func dimmedViewTapped(_ sender: UITapGestureRecognizer) {
        self.hide()
    }
    
    @objc private func closeButtonTapped() {
        self.hide()
    }
}
