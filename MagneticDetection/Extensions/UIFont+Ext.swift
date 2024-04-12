//
//  UIFont+Ext.swift
//  MagneticDetection
//
//  Created by Viktoryia Hermanovich on 08/04/2024.
//

import UIKit

extension UIFont {
    /// Weight: 400
    static func robotoRegular(ofSize size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Roboto-Regular", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }
        return font
     }
    /// Weight: 700
    static func robotoBold(ofSize size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Roboto-Bold", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .bold)
        }
        return font
     }
    
    /// Weight: 500
    static func robotoSemibold(ofSize size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Roboto-Medium", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .semibold)
        }
        return font
     }
}
