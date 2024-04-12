//
//  ScanNetworkViewModel.swift
//  MagneticDetection
//
//  Created by Viktoryia Hermanovich on 11/04/2024.
//

import UIKit
import Combine

protocol ScanNetworkViewModel {
    var devicesPublisher: Published<[DeviceModel]>.Publisher { get }
    
    func navigateToDevices()
}

final class ScanNetworkViewModelImpl: ScanNetworkViewModel {
    // MARK: - Properties
    
    var devicesPublisher: Published<[DeviceModel]>.Publisher { $devices }
    
    @Published private var devices: [DeviceModel] = []
    private var router: Router
    
    // MARK: - Lifecycle
    
    init(router: Router) {
        self.router = router
        scanDevices()
    }

    // MARK: - Functions
    
    func navigateToDevices() {
        router.navigateToDevices(
            viewModel: DevicesViewModelImpl(
                router: router,
                devices: devices.map { model in
                    Device(device: model)
                }
            )
        )
    }
}

// MARK: - Private

private extension ScanNetworkViewModelImpl {
    func scanDevices() {
        if let url = Bundle.main.url(forResource: "devices", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                self.devices = try decoder.decode([DeviceModel].self, from: data)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }
}
