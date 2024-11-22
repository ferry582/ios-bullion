//
//  UIColor+Ext.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 20/11/24.
//

import UIKit

enum Color: String, CaseIterable {
    case blue = "PrimaryBlue"
    case background = "MainBackground"
    case border = "BorderColor"
    case placeholder = "PlaceholderColor"
}

extension UIColor {
    convenience init(color: Color) {
        self.init(named: color.rawValue)!
    }
}
