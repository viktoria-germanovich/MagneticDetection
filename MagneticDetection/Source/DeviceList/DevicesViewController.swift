//
//  DevicesViewController.swift
//  MagneticDetection
//
//  Created by Viktoryia Hermanovich on 10/04/2024.
//

import UIKit

final class DevicesViewController: UIViewController {

    // MARK: - Properties
      
    private let titleStackView = UIStackView(
        axis: .vertical,
        distribution: .fill
    )
    private let devicesStackView = UIStackView(
        axis: .horizontal,
        spacing: 8,
        distribution: .fill
    )
    private let devicesLabel = UILabel()
    private let devicesCountLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let titleLabel = UILabel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.rowHeight = 54
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .appGray
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.separatorStyle = .singleLine
        DeviceCell.registerCell(in: tableView)

        return tableView
    }()
    
    private let viewModel: DevicesViewModel
    
    // MARK: - Lifecycle
    
    init(viewModel: DevicesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = titleLabel
        
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Actions
    
    private func setupUI() {
        view.backgroundColor = .appBackground
        tableView.roundCorners(radius: 8)

        devicesLabel.setText(
            Constant.devices,
            font: .robotoBold(ofSize: Constant.bigTextSize),
            color: .appWhite
        )
        
        devicesCountLabel.setText(
            "\(viewModel.devices.count)",
            font: .robotoBold(ofSize: Constant.bigTextSize),
            color: .appPrimary
        )
        
        subtitleLabel.setText(
            Constant.wifiName,
            font: .robotoRegular(ofSize: 15),
            color: .appGray
        )
        
        titleLabel.setText(
            Constant.title,
            font: .robotoSemibold(ofSize: 17),
            color: .appWhite
        )
    }
    
    private func setupConstraints() {
        view.addSubviews([titleStackView, tableView])
        
        titleStackView.addArrangedSubviews([devicesStackView, subtitleLabel])
        devicesStackView.addArrangedSubviews([devicesCountLabel, devicesLabel])
        
        titleStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(123)
            make.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(titleStackView.snp.bottom).offset(32)
        }
    }
}

// MARK: - UITableViewDataSource Extension

extension DevicesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: DeviceCell = tableView.dequeueReusableCell(for: indexPath) else {
            return UITableViewCell()
        }
        let item = viewModel.devices[indexPath.row]
        cell.update(model: item)

        return cell
    }
}

// MARK: - UITableViewDelegate Extension

extension DevicesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedItem = viewModel.devices[indexPath.row]
        viewModel.deviceDetails(selectedItem)
    }
}

// MARK: - Constant

private  extension DevicesViewController {
    enum Constant {
        // Text
        static let title = "Result"
        static let wifiName = "WIFI_Name"
        static let devices = "Devices"
        // Text size
        static let bigTextSize: CGFloat = 28
    }
}
