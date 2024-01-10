//
//  MovieDetails.swift
//  Domain
//
//  Created by Waleed Saad on 06/01/2024.
//

import Foundation

public struct MovieDetails {
    
    public let title: String?
    public let thumbnail: String?
    public let poster: String?
    public let releaseDate: Date?
    public let genres: MovieGenres?
    public let overview: String?
    public let runtime: Double?
    public let spokenLanguages: [SpokenLanguage]?
    public let status: String?
    public let budget: Double?
    public let revenue: Double?
    public let homepage: String?
    
    public init(title: String?, thumbnail: String?, poster: String?, releaseDate: Date?, genres: MovieGenres?, overview: String?, runtime: Double?, spokenLanguages: [SpokenLanguage]?, status: String?, budget: Double?, revenue: Double?, homepage: String?) {
        self.title = title
        self.thumbnail = thumbnail
        self.poster = poster
        self.releaseDate = releaseDate
        self.genres = genres
        self.overview = overview
        self.runtime = runtime
        self.spokenLanguages = spokenLanguages
        self.status = status
        self.budget = budget
        self.revenue = revenue
        self.homepage = homepage
    }
}
