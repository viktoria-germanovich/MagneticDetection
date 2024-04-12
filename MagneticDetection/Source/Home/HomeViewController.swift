//
//  ViewController.swift
//  MagneticDetection
//
//  Created by Viktoryia Hermanovich on 05/04/2024.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {

    // MARK: - Properties

    // Header
    private var headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .homeDevices
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
     
    private let contentView = UIView()
    private let titleView = TitleView()

    // Scan network
    private let scanNetworkStackView = UIStackView(
        axis: .vertical,
        spacing: 8,
        distribution: .fill
    )
    private let scanNetworkLabel = UILabel()
    private let scanNetworkButton = PrimaryButton()
    private let homeActionView = HomeActionView()
    
    private let scrollView = UIScrollView()
    private let containerView = UIView()

    private let viewModel: HomeViewModel
    
    // MARK: - Lifecycle
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .icFilter, style: .plain, target: self, action: #selector(rightButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .appWhite
        navigationItem.backButtonTitle = Constant.title
        
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Actions
    
    private func setupUI() {
        view.backgroundColor = .appBackground
        
        contentView.backgroundColor = .appPrimaryDark
        contentView.roundCorners(radius: 8)
        
        titleView.setup(
            viewModel: TitleView.ViewModel(
                title: Constant.wifiName,
                subtitle: Constant.currentWiFi
            )
        )

        scanNetworkLabel.setText(
            Constant.readyToScan,
            font: .robotoRegular(ofSize: 17),
            color: .appGray
        )
        
        homeActionView.setup(
            viewModel: HomeActionView.ViewModel(
                infaredDetectionAction: HomeButtonConfig(
                    title: Constant.infaredDetection,
                    icon: .icInfaredDetection
                ),
                bluetoothDetectionAction: HomeButtonConfig(
                    title: Constant.bluetoothDetection,
                    icon: .icBluetoothDetection
                ),
                magneticDetectionAction: HomeButtonConfig(
                    title: Constant.magneticDetection,
                    icon: .icMagneticDetection,
                    action: { [weak self] in
                        self?.viewModel.navigateToMagneticDetection()
                    }
                ),
                antispyTipsAction: HomeButtonConfig(
                    title: Constant.antispyTips, icon: .icAntispyTips
                )
            )
        )
        
        scanNetworkButton.setupTitle(Constant.scanNetwork)
        scanNetworkButton.didPress = { [weak self] in
            self?.viewModel.naviageToScanNetwork()
        }
    }
    
    private func setupConstraints() {
        view.addSubviews([headerImageView, contentView, homeActionView])
        
        contentView.addSubviews([titleView, scanNetworkStackView])

        scanNetworkStackView.addArrangedSubviews([scanNetworkLabel, scanNetworkButton])
        
        headerImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(Constant.imageHeight)
        }
        
        contentView.snp.makeConstraints { make in
            make.bottom.equalTo(homeActionView.snp.top).inset(-Constant.smallInset)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(Constant.standardInset)
        }
        
        titleView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constant.bigInset)
            make.centerX.equalToSuperview()
        }
        
        scanNetworkStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(Constant.bigInset)
            make.top.equalTo(titleView.snp.bottom).offset(Constant.smallInset)
            make.leading.trailing.equalToSuperview().inset(Constant.smallInset)
        }
        
        scanNetworkButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview()
        }
        
        homeActionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(36)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(1)
        }
    }
    
    @objc private func rightButtonTapped() {
        print("Filter tapped")
    }
}

// MARK: - Constant

private extension HomeViewController {
    enum Constant {
        // Adopt image size depending on device
        static let imageHeight = UIDevice.current.screenSize == .small ? 197 : 329 // 0.6 * 329
        // Text
        static let scanNetwork = "Scan current network"
        static let antispyTips = "Antispy Tips"
        static let magneticDetection = "Magnetic Detection"
        static let bluetoothDetection = "Bluetooth Detection"
        static let infaredDetection = "Infared Detection"
        static let readyToScan = "Ready to Scan this network"
        static let currentWiFi = "Current Wi-Fi"
        static let wifiName = "WIFI_Name"
        static let title = "Home"
        // Inset
        static let standardInset = 20
        static let smallInset = 16
        static let bigInset = 24
    }
}
