//
//  MovieDetailsDTOMapper.swift
//  DataTransferObjects
//
//  Created by Waleed Saad on 10/01/2024.
//

import Foundation
import Domain

public struct MovieDetailsDTOMapper {
    
    // MARK: - Properties
    
    private let response: MovieDetailsResponse
    
    // MARK: - Init
    
    public init(response: MovieDetailsResponse) {
        self.response = response
    }
    
    // MARK: - APIs
    
    public func callAsFunction() -> MovieDetails {
        let imagePathFactory = ImagePathFactory()

        return .init(
            title: response.title ?? response.originalTitle,
            thumbnail: imagePathFactory.imagePath(response.backdropPath, imagePath: .thumbnail),
            poster: imagePathFactory.imagePath(response.posterPath, imagePath: .poster),
            releaseDate: response.releaseDate,
            genres: response.genres?.filter { $0.id != nil }.compactMap { .init(id: $0.id!, name: $0.name) },
            overview: response.overview,
            runtime: response.runtime,
            spokenLanguages: response.spokenLanguages?.compactMap { spokenLanguage in
                let name = spokenLanguage.englishName ?? spokenLanguage.name
                return .init(name: name)
            },
            status: response.status,
            budget: response.budget,
            revenue: response.revenue,
            homepage: response.homepage
        )
    }
}
