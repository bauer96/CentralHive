//
//  Employee.swift
//  CentralHive
//
//  Created by Hannes Bauer on 21.01.25.
//

import Foundation
import SwiftData

// TODO: Migrate from ObservableObject to Observable Class iOS 17.0

@Model
class Employee: ObservableObject {
    @Attribute(.unique) var id: UUID
    var firstName: String
    var lastName: String
    var position: String
    var emailAddress: String
    @Relationship(deleteRule: .nullify) var department: Department?  // Can have at most one department
    @Relationship(deleteRule: .nullify) var hardware: Hardware? // Can have at most one hardware
    
    init(id: UUID, firstName: String = "", lastName: String = "", position: String = "", emailAddress: String = "", department: Department? = nil, hardware: Hardware? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.position = position
        self.emailAddress = emailAddress
        self.department = department
        self.hardware = hardware
    }

}
