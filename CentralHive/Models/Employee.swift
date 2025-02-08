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
    var firstName: String
    var lastName: String
    var position: String
    var emailAddress: String
    @Relationship(deleteRule: .nullify) var department: Department?  // Can have at most one department
    // @Relationship(deleteRule: .nullify) var hardware: Hardware? // Can have at most one hardware
    @Relationship(inverse: \Hardware.employee) var hardwareItems: [Hardware] = []
    
    init(id: UUID, firstName: String = "", lastName: String = "", position: String = "", emailAddress: String = "", department: Department? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.position = position
        self.emailAddress = emailAddress
        self.department = department
    }

}
