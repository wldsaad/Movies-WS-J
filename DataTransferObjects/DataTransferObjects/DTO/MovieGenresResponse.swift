//
//  MovieGenresResponse.swift
//  DataTransferObjects
//
//  Created by Waleed Saad on 10/01/2024.
//

import Foundation

public struct MovieGenresResponse: Codable {
    
    public let genres: [MovieGenre]?
}

public struct MovieGenre: Codable {
    
    public let id: Int?
    public let name: String?
}
