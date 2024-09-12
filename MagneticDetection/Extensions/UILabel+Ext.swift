//
//  UILabel+Ext.swift
//  MagneticDetection
//
//  Created by Viktoryia Hermanovich on 05/04/2024.
//

import UIKit

extension UILabel {
    func setText(
        _ text: String?,
        font: UIFont,
        color: UIColor,
        aligment: NSTextAlignment = .center,
        lineHeightMultiple: CGFloat = 1,
        lineBreakMode: NSLineBreakMode = .byWordWrapping
    ) {
        guard let text else {
            self.attributedText = nil
            return
        }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        paragraphStyle.alignment = aligment
        paragraphStyle.lineBreakMode = lineBreakMode
        
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: font,
            .foregroundColor: color
        ]

        self.attributedText = NSAttributedString(string: text, attributes: attributes)
    }

    convenience init(numberOfLines: Int) {
        self.init()

        self.numberOfLines = numberOfLines
    }
}
