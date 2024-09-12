//
//  UITableView+Utils.swift
//  MagneticDetection
//
//  Created by Viktoryia Hermanovich on 10/04/2024.
//

import Foundation
import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T? {
        guard
            let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T
        else {
            assertionFailure("Unable to deque cell with identifier: \(T.reuseIdentifier)")
            return nil
        }
        return cell
    }
}

extension UIView {
    class var name: String {
        return String(describing: self)
    }
}

extension UITableViewCell {
    class var reuseIdentifier: String { name }

    class func registerCell(in tableView: UITableView, with reuseIdentifier: String? = nil) {
        tableView.register(self, forCellReuseIdentifier: reuseIdentifier ?? Self.reuseIdentifier)
    }
}

