//
//  DeviceDetailsViewController.swift
//  MagneticDetection
//
//  Created by Viktoryia Hermanovich on 10/04/2024.
//

import UIKit

final class DeviceDetailsViewController: UIViewController {

    // MARK: - Properties

    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let contentView = UIView()
    private let titleStackView = UIStackView(axis: .vertical)
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    private let infoStackView = UIStackView(
        axis: .vertical,
        spacing: 0.5,
        alignment: .fill,
        distribution: .fillEqually
    )
    
    private let connectionTypeInfo = DeviceInfoView()
    private let apiInfo = DeviceInfoView()
    private let macAddressTypeInfo = DeviceInfoView()
    private let hostnameTypeInfo = DeviceInfoView()
    
    private let viewModel: DeviceDetailsViewModel
    
    // MARK: - Lifecycle
    
    init(viewModel: DeviceDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = Constant.title

        setupUI()
        setupConstraints()
    }
    
    // MARK: - Actions
    
    private func setupUI() {
        view.backgroundColor = .appBackground
        contentView.backgroundColor = .appPrimaryDark
        infoStackView.backgroundColor = .appGray
        contentView.roundCorners(radius: 8)
        
        switch viewModel.device.connectionQuality {
        case .normal:
            headerImageView.image = .connection
            
            titleLabel.setText(
                viewModel.device.name,
                font: .robotoBold(ofSize: Constant.textSize),
                color: .appPrimary
            )
        case .bad:
            headerImageView.image = .connectionBad
            
            titleLabel.setText(
                viewModel.device.name,
                font: .robotoBold(ofSize: Constant.textSize),
                color: .appRed
            )
        }
    
        titleLabel.shadow(color: .appPrimary, opacity: 0.55, radius: 5)
        
        subtitleLabel.setText(
            viewModel.device.ipAddress,
            font: .robotoRegular(ofSize: 15),
            color: .appWhite
        )
        
        setupDeviceInfo()
    }
    
    private func setupDeviceInfo() {
        connectionTypeInfo.setup(
            DeviceInfoView.ViewModel(
                title: Constant.connectionType,
                value: viewModel.device.connectionType 
            )
        )
        
        apiInfo.setup(
            DeviceInfoView.ViewModel(
                title: Constant.ipAddress,
                value: viewModel.device.ipAddress
            )
        )
        
        macAddressTypeInfo.setup(
            DeviceInfoView.ViewModel(
                title: Constant.macAddress,
                value: viewModel.device.macAddress
            )
        )
        
        hostnameTypeInfo.setup(
            DeviceInfoView.ViewModel(
                title: Constant.hostname,
                value: viewModel.device.hostName
            )
        )
    }
    
    private func setupConstraints() {
        view.addSubviews([headerImageView, contentView])
        contentView.addSubviews([titleStackView, infoStackView])
        
        headerImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(329)
        }
        
        contentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(294)
            make.top.equalTo(headerImageView.snp.bottom).offset(-49)
        }
        
        titleStackView.addArrangedSubviews([titleLabel, subtitleLabel])

        titleStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constant.inset)
            make.leading.trailing.equalToSuperview()
        }
        
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(titleStackView.snp.bottom).inset(-Constant.inset)
            make.leading.trailing.equalToSuperview()
        }
        
        infoStackView.addArrangedSubviews([
            connectionTypeInfo,
            apiInfo,
            macAddressTypeInfo,
            hostnameTypeInfo
        ])
    }
}

private extension DeviceDetailsViewController {
    enum Constant {
        // Text
        static let hostname = "Hostname"
        static let macAddress = "MAC Address"
        static let ipAddress = "IP Address"
        static let connectionType = "Connection Type"
        static let title = "Device Details"
        // Text size
        static let textSize: CGFloat = 28
        // Inset
        static let inset = 24
    }
}
