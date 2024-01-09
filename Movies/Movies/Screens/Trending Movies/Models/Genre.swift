//
//  Genre.swift
//  Movies
//
//  Created by Waleed Saad on 06/01/2024.
//

import Foundation
import SwiftData
import Domain

@Model
final class Genre {
    
    // MARK: - Properties
    
    @Attribute(.unique)
    let id: Int
    let name: String
    var selected: Bool
    
    let createdAt = Date()
    
    // MARK: - Init
    
    init(id: Int, name: String, selected: Bool) {
        self.id = id
        self.name = name
        self.selected = selected
    }
    
    init(_ genre: MovieGenre) {
        id = genre.id
        name = genre.name ?? ""
        selected = false
    }
}
