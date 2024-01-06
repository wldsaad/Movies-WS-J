//
//  MovieDetailsView.swift
//  Movies
//
//  Created by Waleed Saad on 06/01/2024.
//

import SwiftUI

struct MovieDetailsView: View {
    
    let movie: Movie
    
    var body: some View {
        ScrollView {
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(movie.title)
    }
}

#Preview {
    MovieDetailsView(movie: .init(movieId: 1, title: "Fight Club", image: "", releaseDate: "", genreIds: []))
}
