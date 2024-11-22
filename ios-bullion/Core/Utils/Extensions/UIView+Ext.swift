//
//  UIView+Ext.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 22/11/24.
//

import UIKit

extension UIView {
    func setGradientBackground() {
        let colors = [
            UIColor(red: 252.0/255.0, green: 104.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor,
            UIColor(red: 240.0/255.0, green: 90.0/255.0, blue: 42.0/255.0, alpha: 1.0).cgColor,
            UIColor(red: 241.0/255.0, green: 186.0/255.0, blue: 168.0/255.0, alpha: 1.0).cgColor
        ]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = [0.0, 0.4, 0.8]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = self.bounds
        
        self.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
