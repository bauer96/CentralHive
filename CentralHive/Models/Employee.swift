//
//  Employee.swift
//  CentralHive
//
//  Created by Hannes Bauer on 21.01.25.
//

import Foundation
import SwiftData

@Model
class Employee {
    @Attribute(.unique) var id: UUID
    var name: String
    var position: String
    var department: Department?
    
    init(id: UUID, name: String, position: String, department: Department? = nil) {
        self.id = id
        self.name = name
        self.position = position
        self.department = department
    }
    
}
