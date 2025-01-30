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
    @Relationship var employee: Employee?
    
    init(id: UUID, name: String, serialNumber: String, model: String, employee: Employee? = nil) {
        self.id = id
        self.name = name
        self.serialNumber = serialNumber
        self.model = model
        self.employee = employee
    }
    
//    init(id: UUID, name: String, serialNumber: String, model: String) {
//        self.id = id
//        self.name = name
//        self.serialNumber = serialNumber
//        self.model = model
//    }
//    

}
