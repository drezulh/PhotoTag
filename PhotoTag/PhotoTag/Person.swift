//
//  Person.swift
//  PhotoTag
//
//  Created by Gorkem Turan on 15.01.2023.
//

import SwiftUI

struct Person: Identifiable, Codable, Comparable {
    var id = UUID()
    var jpegData: Data
    var name: String
    
    static func <(lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
}

