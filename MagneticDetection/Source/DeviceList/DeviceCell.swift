//
//  DeviceCell.swift
//  MagneticDetection
//
//  Created by Viktoryia Hermanovich on 10/04/2024.
//

import UIKit

final class DeviceCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let contentStackView = UIStackView(
        axis: .horizontal,
        spacing: 16
    )
    
    private let infoStackView = UIStackView(
        axis: .vertical,
        alignment: .leading,
        distribution: .fillEqually
    )
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let actionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .icArrowRight
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nameLabel = UILabel()
    private let apiAdressLabel = UILabel()
    

    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .appPrimaryDark
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions

    func update(model: Device) {
        switch model.connectionQuality {
        case .normal:
            iconImageView.image = .icWifi
            
        case .bad:
            iconImageView.image = .icWifiBad
        }
        
        nameLabel.setText(
            model.name,
            font: .robotoSemibold(ofSize: 17),
            color: .appWhite,
            aligment: .left
        )
        
        apiAdressLabel.setText(
            model.ipAddress,
            font: .robotoSemibold(ofSize: 13),
            color: .appGray,
            aligment: .left
        )
    }
    
    private func setupConstraints() {
        contentView.addSubviews([contentStackView, actionImageView])
        
        contentStackView.addArrangedSubviews([iconImageView, infoStackView])
        infoStackView.addArrangedSubviews([nameLabel, apiAdressLabel])
        
        contentStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(7)
        }
        
        actionImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(19)
        }
    }
}
