//
//  MovieGenre.swift
//  Domain
//
//  Created by Waleed Saad on 06/01/2024.
//

import Foundation

public typealias MovieGenres = [MovieGenre]

public struct MovieGenre {
    
    public let id: Int
    public let name: String?
    
    public init(id: Int, name: String?) {
        self.id = id
        self.name = name
    }
}
