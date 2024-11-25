//
//  CALayer+Ext.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 25/11/24.
//

import UIKit

extension CALayer {
    func applyDropShadow(color: UIColor = .black, alpha: Float = 0.5, x: CGFloat, y: CGFloat, blur: CGFloat, spread: CGFloat = 0) {
        
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / UIScreen.main.scale
        masksToBounds = false
        
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect  = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
