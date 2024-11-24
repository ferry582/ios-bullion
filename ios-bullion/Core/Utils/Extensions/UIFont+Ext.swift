//
//  UIFont+Ext.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 21/11/24.
//

import UIKit


enum CustomFonts: String {
    case roboto = "Roboto"
    case inter = "Inter"
}

enum CustomFontStyle: String {
    case bold = "-Bold"
    case semibold = "-SemiBold"
    case medium = "-Medium"
    case regular = "-Regular"
}

extension UIFont {
    static func customFont(font: CustomFonts, style: CustomFontStyle, size: CGFloat) -> UIFont {
        let fontName: String = font.rawValue + style.rawValue
        guard let font = UIFont(name: fontName, size: size) else {
            debugPrint("Font can't be loaded")
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
}

