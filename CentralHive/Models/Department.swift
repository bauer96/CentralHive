//
//  Department.swift
//  CentralHive
//
//  Created by Hannes Bauer on 21.01.25.
//


import Foundation
import SwiftData
import Observation


@Model
class Department {
    @Attribute(.unique) var id: UUID
    var name: String
    @Relationship(inverse: \Employee.department) var employees: [Employee] = []

    init(id: UUID = UUID(), name: String, employees: [Employee] = []) {
        self.id = id
        self.name = name
        self.employees = employees
    }
}
