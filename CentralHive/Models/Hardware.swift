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
    var serialNumber: String
    var model: String
    var employee: Employee?
    
    init(id: UUID, serialNumber: String, model: String) {
        self.id = id
        self.serialNumber = serialNumber
        self.model = model
    }
}
