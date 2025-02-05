//
//  Hardware.swift
//  CentralHive
//
//  Created by Hannes Bauer on 21.01.25.
//


import Foundation
import SwiftData

// TODO: Migrate from ObservableObject to Observable Class iOS 17.0

@Model
class Hardware: ObservableObject {
    @Attribute(.unique) var id: UUID
    var name: String
    var serialNumber: String
    var model: String
    var os: String
    var ram: String
    var storage: String
    var purchaseDate: Date?
    var warrantyExpiry: Date?
    @Relationship(deleteRule: .nullify, inverse: \Employee.hardware) var employee: Employee?  // Can be assigned to at most one employee
    
    init(id: UUID, name: String, serialNumber: String, model: String, os: String, ram: String, storage: String, purchaseDate: Date = Date(), warantyExpiry: Date = Calendar.current.date(byAdding: .year, value: 2, to: Date())!, employee: Employee? = nil) {
        self.id = id
        self.name = name
        self.serialNumber = serialNumber
        self.model = model
        self.os = os
        self.ram = ram
        self.storage = storage
        self.purchaseDate = purchaseDate
        self.warrantyExpiry = warantyExpiry
        self.employee = employee
    }

//    init(id: UUID = UUID(), name: String, serialNumber: String, model: String, employee: Employee? = nil) {
//        self.id = id
//        self.name = name
//        self.serialNumber = serialNumber
//        self.model = model
//        self.employee = employee
//
//    }
}

//    init(id: UUID, name: String, serialNumber: String, model: String) {
//        self.id = id
//        self.name = name
//        self.serialNumber = serialNumber
//        self.model = model
//    }
//


