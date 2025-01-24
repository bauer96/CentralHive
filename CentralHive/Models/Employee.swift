//
//  Employee.swift
//  CentralHive
//
//  Created by Hannes Bauer on 21.01.25.
//

import Foundation
import SwiftData

@Model
class Employee: ObservableObject {
    @Attribute(.unique) var id: UUID
    var name: String
    var position: String
    @Relationship var department: Department?
    @Relationship var hardware: Hardware?
 
    init(name: String, position: String, department: Department?, hardware: Hardware? = nil) {
        self.id = UUID()
        self.name = name
        self.position = position
        self.department = department
        self.hardware = hardware
    }
    
}
