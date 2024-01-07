//
//  MoviePropertiesView.swift
//  Movies
//
//  Created by Waleed Saad on 07/01/2024.
//

import SwiftUI

struct MoviePropertiesView: View {
    
    // MARK: - Types
    
    private struct PropertyData: Identifiable {
        let id = UUID()
        let title: String
        let description: String?
    }
    
    // MARK: - Properties
    
    let movie: MovieDetails
    
    var body: some View {
        VStack(alignment: .leading) {
            if !movie.homepage.isEmpty {
                MoviePropertyView(viewModel: .init(title: "Home Page", type: .hyperlink(movie.homepage)))
            }
            
            if !movie.spokenLanguages.isEmpty {
                MoviePropertyView(viewModel: .init(title: "Languages", type: .plain(movie.spokenLanguages)))
            }
            
            let properties: [PropertyData] = [
                .init(title: "Status", description: movie.status),
                .init(title: "Runtime", description: movie.runtime),
                .init(title: "Budget", description: movie.budget),
                .init(title: "Revenue", description: movie.revenue)
            ].filter { !($0.description?.isEmpty ?? true) }
            
            LazyVGrid(
                columns: Array(repeatElement(GridItem(.flexible()), count: 2))
            ) {
                ForEach(properties) { property in
                    MoviePropertyView(viewModel: .init(title: property.title, type: .plain(property.description ?? "")))
                }
            }
        }
    }
}
