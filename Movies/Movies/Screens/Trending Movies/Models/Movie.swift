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
final class Movie: Equatable, Hashable, Identifiable {
    
    // MARK: - Properties
    
    let id = UUID()
    let movieId: Int
    let title: String
    let thumbnail: String
    let releaseDate: String
    let genreIds: [Int]
    
    // MARK: - Init
    
    init(movieId: Int, title: String, image: String, releaseDate: String, genreIds: [Int]) {
        self.movieId = movieId
        self.title = title
        self.thumbnail = image
        self.releaseDate = releaseDate
        self.genreIds = genreIds
    }
    
    init(movie: TrendingMovie) {
        movieId = movie.id
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
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
