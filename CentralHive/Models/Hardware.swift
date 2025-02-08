//
//  Hardware.swift
//  CentralHive
//
//  Created by Hannes Bauer on 21.01.25.
//


import Foundation
import SwiftData

@Model
class Hardware {
    @Attribute(.unique) var id: UUID
    var name: String
    var model: String
    var serialNumber: String
    var os: String
    var ram: String
    var storage: String
    var purchaseDate: Date?
    var warrantyExpiry: Date?
    // Make type optional during migration
    var type: HardwareType?
    var employee: Employee?

    init(id: UUID = UUID(), name: String, model: String, serialNumber: String, os: String = "", ram: String = "", storage: String = "", purchaseDate: Date? = nil, warrantyExpiry: Date? = nil, type: HardwareType? = .other) {
        self.id = id
        self.name = name
        self.model = model
        self.serialNumber = serialNumber
        self.os = os
        self.ram = ram
        self.storage = storage
        self.purchaseDate = purchaseDate
        self.warrantyExpiry = warrantyExpiry
        self.type = type
    }
}

enum HardwareType: String, Codable, CaseIterable {
    case laptop
    case smartphone
    case tablet
    case desktop
    case monitor
    case other
}



