////
////  HomeActionView.swift
////  MagneticDetection
////
////  Created by Viktoryia Hermanovich on 08/04/2024.
////


import UIKit

final class HomeActionView: UIView {

    // MARK: - Properties
    
    private let contentView = UIStackView(
        axis: .vertical,
        spacing: Constant.verticalSpacing,
        distribution: .fillEqually
    )
    private let actionsFirstRow = UIStackView(
        axis: .horizontal,
        spacing: Constant.horizontalSpacing,
        distribution: .fillEqually
    )

    private let actionsSecondRow = UIStackView(
        axis: .horizontal,
        spacing: Constant.horizontalSpacing,
        distribution: .fillEqually
    )
    
    private let infaredDetectionButton = HomeActionButton()
    private let bluetoothDetectionButton = HomeActionButton()
    private let magneticDetectionButton = HomeActionButton()
    private let antispyTipsButton = HomeActionButton()
    
    // MARK: - Lifecycle
    
    init() {
        super.init(frame: .zero)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    func setup(viewModel: ViewModel) {
        shadow(
            color: .appPrimaryShadow,
            opacity: 1,
            radius: 24,
            offset: CGSize(width: 8, height: 8)
        )
        infaredDetectionButton.setup(viewModel.infaredDetectionAction)
        bluetoothDetectionButton.setup(viewModel.bluetoothDetectionAction)
        magneticDetectionButton.setup(viewModel.magneticDetectionAction)
        antispyTipsButton.setup(viewModel.antispyTipsAction)
    }
    
    private func setupConstraints() {
        addSubview(contentView)
        contentView.addArrangedSubviews([actionsFirstRow, actionsSecondRow])
        
        actionsFirstRow.addArrangedSubviews([infaredDetectionButton, bluetoothDetectionButton])
        actionsSecondRow.addArrangedSubviews([magneticDetectionButton, antispyTipsButton])
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let buttons = [
            infaredDetectionButton,
            bluetoothDetectionButton,
            magneticDetectionButton,
            antispyTipsButton
        ]
        
        buttons.forEach { button in
            button.snp.makeConstraints { make in
                make.height.equalTo(button.snp.width)
            }
        }
    }
}

// MARK: - Model

extension HomeActionView {
    struct ViewModel {
        let infaredDetectionAction: HomeButtonConfig
        let bluetoothDetectionAction: HomeButtonConfig
        let magneticDetectionAction: HomeButtonConfig
        let antispyTipsAction: HomeButtonConfig
    }
}

// MARK: - Constant

private extension HomeActionView {
    enum Constant {
        static let verticalSpacing: CGFloat = 35
        static let horizontalSpacing: CGFloat = 38
    }
}
