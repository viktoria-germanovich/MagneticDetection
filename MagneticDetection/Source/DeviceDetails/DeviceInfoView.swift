//
//  DeviceInfoView.swift
//  MagneticDetection
//
//  Created by Viktoryia Hermanovich on 10/04/2024.
//

import UIKit

final class DeviceInfoView: UIView {
    // MARK: - Properties
    
    private let contentStackView = UIStackView(
        axis: .horizontal,
        alignment: .fill
    )
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    
    private let viewModel = ViewModel(title: "", value: "")
    
    // MARK: - Lifecycle
    
    init() {
        super.init(frame: .zero)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    func setup(_ viewModel: ViewModel) {
        backgroundColor = .appPrimaryDark
        
        titleLabel.setText(
            viewModel.title,
            font: .robotoRegular(ofSize: Constant.textSize),
            color: .appWhite,
            aligment: .left
        )
        
        valueLabel.setText(
            viewModel.value,
            font: .robotoRegular(ofSize: Constant.textSize),
            color: .appGray,
            aligment: .right
        )
    }
    
    private func setupConstraints() {
        addSubview(contentStackView)
        contentStackView.addArrangedSubviews([titleLabel, valueLabel])
        
        contentStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
}

// MARK: - Model

extension DeviceInfoView {
    struct ViewModel {
        let title: String
        let value: String
    }
}

// MARK: - Constant

private extension DeviceInfoView {
    enum Constant {
        static let textSize: CGFloat = 17
    }
}
