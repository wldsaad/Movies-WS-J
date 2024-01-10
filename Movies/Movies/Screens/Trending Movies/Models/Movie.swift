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
    let title: String
    let image: String
    let releaseDate: String
    let genreIds: [Int]
    
    // MARK: - Init
    
    init(title: String, image: String, releaseDate: String, genreIds: [Int]) {
        self.title = title
        self.image = image
        self.releaseDate = releaseDate
        self.genreIds = genreIds
    }
    
    init(movie: TrendingMovie) {
        title = movie.title ?? ""
        image = movie.image ?? ""
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
