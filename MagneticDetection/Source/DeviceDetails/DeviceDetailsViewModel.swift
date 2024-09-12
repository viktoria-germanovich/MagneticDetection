//
//  DeviceDetailsViewModel.swift
//  MagneticDetection
//
//  Created by Viktoryia Hermanovich on 11/04/2024.
//

protocol DeviceDetailsViewModel {
    var device: Device { get }
}

final class DeviceDetailsViewModelImpl: DeviceDetailsViewModel {
    private(set) var device: Device
    
    init(device: Device) {
        self.device = device
    }
}

