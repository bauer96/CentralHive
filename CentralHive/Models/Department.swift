//
//  Department.swift
//  CentralHive
//
//  Created by Hannes Bauer on 21.01.25.
//

import Foundation
import SwiftData

@Model
class Department {
    @Attribute(.unique) var id: UUID
    var name: String
    var employees: [Employee] = []
    
    init(name: String) {
        self.id = UUID()
        self.name = name
        
    }
}
