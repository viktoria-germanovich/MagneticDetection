//
//  DeviceModel.swift
//  MagneticDetection
//
//  Created by Viktoryia Hermanovich on 10/04/2024.
//

// Decodable model
struct DeviceModel: Decodable {
    let connectionQuality: String
    let name: String
    let ipAddress: String
    let hostName: String?
    let macAddress: String?
    let connectionType: String?
}

// UI model
struct Device {
    let connectionQuality: ConnectionQuality
    let name: String
    let ipAddress: String
    let hostName: String
    let macAddress: String
    let connectionType: String
}

extension Device {
    init(device: DeviceModel) {
        self.connectionQuality = ConnectionQuality(device.connectionQuality)
        self.name = device.name
        self.ipAddress = device.ipAddress
        self.hostName = device.hostName ?? "Not Avaliable"
        self.macAddress = device.macAddress ?? "Not Avaliable"
        self.connectionType = device.connectionType ?? "Wifi"
    }
}

enum ConnectionQuality: String {
    case normal = "NORMAL"
    case bad = "BAD"
}

extension ConnectionQuality {
    init(_ value: String) {
        self = ConnectionQuality(rawValue: value.uppercased()) ?? .normal
    }
}
