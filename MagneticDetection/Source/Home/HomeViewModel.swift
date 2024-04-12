//
//  HomeViewModel.swift
//  MagneticDetection
//
//  Created by Viktoryia Hermanovich on 11/04/2024.
//

import Combine

protocol HomeViewModel {
    func navigateToMagneticDetection()
    func naviageToScanNetwork()
}

final class HomeViewModelImpl: HomeViewModel {
    weak var router: Router?
    
    func navigateToMagneticDetection() {
        guard let router else { return }
        router.navigateToMagneticDetection(
            viewModel: MagneticDetectionViewModelImpl()
        )
    }
    
    func naviageToScanNetwork() {
        guard let router else { return }
        router.navigateToScanNetwork(
            viewModel: ScanNetworkViewModelImpl(router: router)
        )
    }
}


