//
//  UILabel+Ext.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 22/11/24.
//

import UIKit

extension UILabel {
    func setGradientColor() {
        // Create gradient layer for UILabel
        let colors = [
            UIColor(red: 145.0/255.0, green: 54.0/255.0, blue: 26.0/255.0, alpha: 1.0).cgColor,
            UIColor(red: 240.0/255.0, green: 90.0/255.0, blue: 42.0/255.0, alpha: 1.0).cgColor,
            UIColor(red: 248.0/255.0, green: 149.0/255.0, blue: 118.0/255.0, alpha: 1.0).cgColor
        ]
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = colors
        gradient.locations = [0.0, 0.5, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
        
        // Create an image from the gradient layer and get color from that image
        UIGraphicsBeginImageContext(gradient.bounds.size)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        gradient.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
        UIGraphicsEndImageContext()
        
        let color = UIColor(patternImage: image)
        textColor = color
    }
}
