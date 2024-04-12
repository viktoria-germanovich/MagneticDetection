//
//  MagneticDetectionViewModel.swift
//  MagneticDetection
//
//  Created by Viktoryia Hermanovich on 11/04/2024.
//

import Combine

enum MagneticDetectionState {
    case searching
    case inactive
}

protocol MagneticDetectionViewModel {
    var statePublisher: Published<MagneticDetectionState>.Publisher { get }
    
    func search()
    func stopSearching()
}

final class MagneticDetectionViewModelImpl: MagneticDetectionViewModel {
    @Published private var state: MagneticDetectionState = .inactive
    var statePublisher: Published<MagneticDetectionState>.Publisher { $state }
    
    func search() {
        state = .searching
    }
    
    func stopSearching() {
        state = .inactive
    }
}
