//
//  UIDevice+Ext.swift
//  MagneticDetection
//
//  Created by Viktoryia Hermanovich on 12/04/2024.
//

import UIKit

extension UIDevice {
    enum ScreenSizeType: String {
        case small // iPhone 5 screen like devices
        case normal // any other iPhones
    }

    var screenSize: ScreenSizeType {
        switch UIScreen.main.nativeBounds.height {
        case 1136, 1334 : return .small
        default: return .normal
        }
    }
}
