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
        genres = GenreTitleGenerator()(movie.genres)
        spokenLanguages = SpokenLanguagesTitleGenerator()(movie.spokenLanguages)
        runtime = RuntimeTitleGenerator()(movie.runtime)
        releaseDate = ReleaseDateTitleGenerator()(movie.releaseDate)
        
        let moneyTitleGenerator = MoneyTitleGenerator()
        budget = moneyTitleGenerator(movie.budget)
        revenue = moneyTitleGenerator(movie.revenue)
    }
}
