//
//  TitleView.swift
//  MagneticDetection
//
//  Created by Viktoryia Hermanovich on 09/04/2024.
//

import UIKit

final class TitleView: UIView {
    struct ViewModel {
        let title: String
        let subtitle: String
    }
    
    // MARK: - Properties
    
    private let contentStackView = UIStackView(
        axis: .vertical,
        distribution: .fill
    )
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    // MARK: - Lifecycle
    
    init() {
        super.init(frame: .zero)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewModel: ViewModel) {
        subtitleLabel.setText(
            viewModel.subtitle,
            font: .robotoRegular(ofSize: 15),
            color: .appWhite,
            lineHeightMultiple: 1.1
        )
        
        titleLabel.setText(
            viewModel.title,
            font: .robotoBold(ofSize: 28),
            color: .appPrimary
        )
        titleLabel.shadow(color: .appPrimary, opacity: 0.55, radius: 5)
    }
}

// MARK: - Private

private extension TitleView {
    func setupConstraints() {
        addSubview(contentStackView)
        contentStackView.addArrangedSubviews([subtitleLabel, titleLabel])
        
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
