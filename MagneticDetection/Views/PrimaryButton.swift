//
//  PrimaryButton.swift
//  MagneticDetection
//
//  Created by Viktoryia Hermanovich on 08/04/2024.
//

import UIKit

class PrimaryButton: UIButton {
    
    // MARK: - Callback
    
    var didPress: (() -> Void)?
    
    // MARK: - Lifecycle

    init() {

        super.init(frame: .zero)

        self.backgroundColor = .appPrimary
        self.roundCorners(radius: 25)
    
        addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        contentHorizontalAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTitle(_ title: String, color: UIColor = .appWhite) {
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        setTitleColor(color.withAlphaComponent(0.3), for: .highlighted)
        setTitleColor(color.withAlphaComponent(0.3), for: .disabled)
        titleLabel?.font = .robotoSemibold(ofSize: 20)
    }
    
    // MARK: - Private
    
    @objc private func buttonAction() {
        didPress?()
    }
}
