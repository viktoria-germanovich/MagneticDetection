//
//  Router.swift
//  MagneticDetection
//
//  Created by Viktoryia Hermanovich on 11/04/2024.
//

import UIKit

protocol Router: AnyObject {
    func navigateToMagneticDetection(viewModel: MagneticDetectionViewModel)
    func navigateToDevices(viewModel: DevicesViewModel)
    func navigateToScanNetwork(viewModel: ScanNetworkViewModel)
    func navigateToDeviceDetails(viewModel: DeviceDetailsViewModel)
}

final class AppRouter: Router {

    private var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    @objc
    private func backButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }

    func navigateToMagneticDetection(viewModel: MagneticDetectionViewModel) {
        let vc = MagneticDetectionViewController(viewModel: viewModel)
        push(vc, animated: true)
    }
    
    func navigateToScanNetwork(viewModel: ScanNetworkViewModel) {
        let vc = ScanNetworkViewController(viewModel: viewModel)
        present(vc, animated: true)
    }
    
    func navigateToDevices(viewModel: DevicesViewModel) {
        let vc = DevicesViewController(viewModel: viewModel)
        push(vc, animated: true)
    }
    
    func navigateToDeviceDetails(viewModel: DeviceDetailsViewModel) {
        let vc = DeviceDetailsViewController(viewModel: viewModel)
        push(vc, animated: true)
    }
}

extension AppRouter {
    private func present(_ viewController: UIViewController, animated: Bool) {
        navigationController?.present(viewController, animated: animated)
    }

    private func push(_ viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}

