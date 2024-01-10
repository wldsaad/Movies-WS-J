//
//  MovieDetails.swift
//  Movies
//
//  Created by Waleed Saad on 06/01/2024.
//

import Foundation
import SwiftData
import Domain

@Model
final class MovieDetails {
    
    // MARK: - Properties
    
    let title: String
    let thumbnail: String
    let poster: String
    let genres: String
    let overview: String
    let homepage: String
    let budget: String
    let revenue: String
    let spokenLanguages: String
    let status: String
    let runtime: String
    let releaseDate: String
    
    // MARK: - Init
    
    init(title: String, thumbnail: String, poster: String, genres: String, overview: String, homepage: String, budget: String, revenue: String, spokenLanguages: String, status: String, runtime: String, releaseDate: String) {
        self.title = title
        self.thumbnail = thumbnail
        self.poster = poster
        self.genres = genres
        self.overview = overview
        self.homepage = homepage
        self.budget = budget
        self.revenue = revenue
        self.spokenLanguages = spokenLanguages
        self.status = status
        self.runtime = runtime
        self.releaseDate = releaseDate
    }
    
    init(movie: Domain.MovieDetails) {
        title = movie.title ?? ""
        thumbnail = movie.thumbnail ?? ""
        poster = movie.poster ?? ""
        overview = movie.overview ?? ""
        homepage = movie.homepage ?? ""
        status = movie.status ?? ""
        
        genres = movie.genres?.compactMap { $0.name }.joined(separator: ", ") ?? ""
        spokenLanguages = movie.spokenLanguages?.compactMap { $0.name }.joined(separator: ", ") ?? ""

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = "USD"
        numberFormatter.currencySymbol = "$"
        budget = numberFormatter.string(for: movie.budget) ?? ""
        revenue = numberFormatter.string(for: movie.revenue) ?? ""
        
        runtime = {
            if let runtime = movie.runtime {
                let formatter = DateComponentsFormatter()
                formatter.allowedUnits = [.hour, .minute]
                formatter.unitsStyle = .abbreviated
                return formatter.string(from: runtime * 60) ?? ""
            }
            return ""
        }()
        
        releaseDate = {
            let month = movie.releaseDate?.formatted(Date.FormatStyle().month(.abbreviated))
            let year = movie.releaseDate?.formatted(Date.FormatStyle().year())
            return [month, year].compactMap { $0 }.joined(separator: " ")
        }()
    }
}
