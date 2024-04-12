//
//  AnimatedControl.swift
//  MagneticDetection
//
//  Created by Viktoryia Hermanovich on 11/04/2024.
//

import UIKit

class AnimatedControl: UIControl {
    
    // MARK: - Properties
    
    private let selectedStateAlpha: CGFloat = 0.3
    private let defaultStateAlpha: CGFloat = 1.0
    private let animationDuration: CGFloat = 0.25
    override var isEnabled: Bool {
        didSet {
            alpha = super.isEnabled ? defaultStateAlpha: selectedStateAlpha
        }
    }
    
    // MARK: - Public
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        animateAlpha(selectedStateAlpha)
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        animateAlpha(defaultStateAlpha)
        super.touchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        animateAlpha(defaultStateAlpha)
        super.touchesCancelled(touches, with: event)
    }
    
    // MARK: - Private
    
    private func animateAlpha(_ alpha: CGFloat) {
        UIView.animate(withDuration: animationDuration) { [weak self] in
            self?.alpha = alpha
        }
    }
}
