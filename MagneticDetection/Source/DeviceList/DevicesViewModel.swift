//
//  DevicesViewModel.swift
//  MagneticDetection
//
//  Created by Viktoryia Hermanovich on 11/04/2024.
//

protocol DevicesViewModel {
    var devices: [Device] { get }
    
    func deviceDetails(_ item: Device)
}

final class DevicesViewModelImpl: DevicesViewModel {
    private(set) var devices: [Device]
    private var router: Router
    
    init(router: Router, devices: [Device]) {
        self.router = router
        self.devices = devices
    }
    
    func deviceDetails(_ item: Device) {
        router.navigateToDeviceDetails(
            viewModel: DeviceDetailsViewModelImpl(device: item)
        )
    }
}
