//
//  ScanNetworkViewController.swift
//  MagneticDetection
//
//  Created by Viktoryia Hermanovich on 08/04/2024.
//

import UIKit
import Lottie
import Combine

final class ScanNetworkViewController: UIViewController {

    // MARK: - Properties
    
    private let stopButton = PrimaryButton()
    private let titleView = TitleView()
    private let scanAnimationView = LottieAnimationView(name: Constant.animationJson)
    private let percentLabel = UILabel()
    private let devicesStackView = UIStackView(
        axis: .horizontal,
        spacing: 8,
        distribution: .fill
    )
    private let devicesCountLabel = UILabel()
    private let devicesLabel = UILabel()
    
    private let viewModel: ScanNetworkViewModel
    private var disposeBag: Set<AnyCancellable> = []
    
    // MARK: - Lifecycle
    
    init(viewModel: ScanNetworkViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        setupUI()
        setupConstraints()
        startAnimation()
    }
    
    // MARK: - Actions
    
    private func bind() {
        viewModel.devicesPublisher
            .sink { [weak self] devices in
                self?.setupDevicesCount(count: devices.count)
            }
            .store(in: &disposeBag)
    }
    
    private func startAnimation() {
        scanAnimationView.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [weak self] in
            self?.stopAnimation()
        }
    }
    
    private func stopAnimation() {
        scanAnimationView.stop()
        dismiss(animated: false, completion: { [weak self] in
            self?.viewModel.navigateToDevices()
        })
    }
    
    private func setupDevicesCount(count: Int) {
        devicesCountLabel.setText(
            "\(count)",
            font: .robotoBold(ofSize: 27),
            color: .appPrimary,
            aligment: .left
        )
    }
    
    private func setupUI() {
        view.backgroundColor = .appBackground
        
        scanAnimationView.loopMode = .loop
        
        titleView.setup(
            viewModel: TitleView.ViewModel(
                title: Constant.deviceName,
                subtitle: Constant.scanningWifi
            )
        )
        
        percentLabel.setText(
            Constant.percentValue,
            font: .robotoSemibold(ofSize: Constant.textSize),
            color: .appWhite
        )

        devicesLabel.setText(
            Constant.devicesFound,
            font: .robotoSemibold(ofSize: Constant.textSize),
            color: .appWhite,
            aligment: .left
        )
        
        stopButton.setupTitle(Constant.stop)
        stopButton.didPress = { [weak self] in
            self?.stopAnimation()
        }
    }
    
    private func setupConstraints() {
        view.addSubviews([titleView, scanAnimationView, percentLabel, devicesStackView, stopButton])
        devicesStackView.addArrangedSubviews([devicesCountLabel, devicesLabel])
        
        titleView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constant.standardInset)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(scanAnimationView.snp.top).inset(-71)
        }
        
        scanAnimationView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(Constant.imageSize)
        }
        
        percentLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        devicesStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scanAnimationView.snp.bottom).offset(32)
        }
        
        stopButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(Constant.standardInset)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(36)
        }
    }
}

// MARK: - Constant

private extension ScanNetworkViewController {
    enum Constant {
        // Adopt view size depending on device
        static let imageSize = UIDevice.current.screenSize == .small ? 280 : 350 // 350 * 0.8
        // Text
        static let stop = "Stop"
        static let devicesFound = "Devices Found..."
        static let percentValue = "20%"
        static let scanningWifi = "Scanning Your Wi-Fi"
        static let deviceName = "TLind_246_lp"
        // Json name
        static let animationJson = "scan_animation.json"
        // Text size
        static let textSize: CGFloat = 17
        // Inset
        static let standardInset = 20
    }
}
