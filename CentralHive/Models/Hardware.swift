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
    var ram: Int
    var storage: Int
    var purchaseDate: Date?
    var warrantyExpiry: Date?
   
    var type: HardwareType?
    var employee: Employee?
    
    
    var formattedRAM: String {
        return "\(ram) GB"
    }
    
    var formattedStorage: String {
        return "\(storage) GB"
    }
    

    init(id: UUID = UUID(), name: String, model: String, serialNumber: String, os: String = "", ram: Int, storage: Int, purchaseDate: Date? = nil, warrantyExpiry: Date? = nil, type: HardwareType? = .other) {
        self.id = id
        self.name = name
        self.model = model
        self.serialNumber = serialNumber
        self.os = os
        self.ram = ram
        self.storage = storage
        self.purchaseDate = purchaseDate?.normalizedDate()
        self.warrantyExpiry = warrantyExpiry?.normalizedDate()
        self.type = type
    }
}

extension Date {
    func normalizedDate() -> Date {
        return Calendar.current.startOfDay(for: self) // Sets time to 00:00:00
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



