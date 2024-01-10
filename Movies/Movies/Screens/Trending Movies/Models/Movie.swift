//
//  Movie.swift
//  Movies
//
//  Created by Waleed Saad on 05/01/2024.
//

import Foundation
import SwiftData
import Domain

@Model
final class Movie: Equatable, Identifiable {
    
    // MARK: - Properties
    
    @Attribute(.unique)
    let id: Int
    let title: String
    let thumbnail: String
    let releaseDate: String
    let genreIds: [Int]
    
    let createdAt = Date()
    
    // MARK: - Init
    
    init(id: Int, title: String, image: String, releaseDate: String, genreIds: [Int]) {
        self.id = id
        self.title = title
        self.thumbnail = image
        self.releaseDate = releaseDate
        self.genreIds = genreIds
    }
    
    init(movie: TrendingMovie) {
        id = movie.id
        title = movie.title ?? ""
        thumbnail = movie.thumbnail ?? ""
        releaseDate = {
            if let releaseDate = movie.releaseDate {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy"
                return formatter.string(from: releaseDate)
            }
            
            return ""
        }()
        genreIds = movie.genreIds ?? []
    }
}
