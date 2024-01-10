//
//  MovieGenresResponse.swift
//  Repository
//
//  Created by Waleed Saad on 06/01/2024.
//

import Foundation

struct MovieGenresResponse: Codable {
    
    let genres: [MovieGenre]?
}

struct MovieGenre: Codable {
    
    let id: Int?
    let name: String?
}
