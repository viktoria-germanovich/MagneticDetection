//
//  HomeActionButton.swift
//  MagneticDetection
//
//  Created by Viktoryia Hermanovich on 08/04/2024.
//

import UIKit

struct HomeButtonConfig {
    var title: String
    var icon: UIImage
    var action: (() -> Void)?
}

final class HomeActionButton: AnimatedControl {
    
    // MARK: - Properties
    
    private var didPress: (() -> Void)?
    
    private let contentStackView = UIStackView(
        axis: .vertical,
        spacing: 8,
        distribution: .fill
    )
    
    private let textLabel = UILabel(numberOfLines: 0)
    private let iconImageView = UIImageView()
    
    // MARK: - Lifecycle
    
    init() {
        super.init(frame: .zero)

        backgroundColor = .appPrimaryShadow
        
        roundCorners(radius: 8)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(_ viewModel: HomeButtonConfig) {
        iconImageView.image = viewModel.icon
        textLabel.setText(
            viewModel.title,
            font: .robotoSemibold(ofSize: Constant.textSize),
            color: .appWhite
        )
        didPress = viewModel.action
        iconImageView.contentMode = .scaleAspectFit
    }
    
    // MARK: - Actions
    
    private func setupConstraints() {
        addSubview(contentStackView)
        contentStackView.isUserInteractionEnabled = false
        contentStackView.addArrangedSubviews([iconImageView, textLabel])
        
        contentStackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(30)
        }
        iconImageView.snp.makeConstraints { make in
            make.height.width.equalTo(Constant.imageSize)
        }
    }
    
    @objc private func buttonTapped() {
        didPress?()
    }
}

// MARK: - Constant

private extension HomeActionButton {
    enum Constant {
        static let textSize: CGFloat = UIDevice.current.screenSize == .small ? 14 : 17
        static let imageSize = UIDevice.current.screenSize == .small ? 22 : 44
    }
}
