//
//  TrendingMoviesListView.swift
//  Movies
//
//  Created by Waleed Saad on 06/01/2024.
//

import SwiftUI
import Combine

struct TrendingMoviesListView: View {
    
    var movies: [Movie]
    
    var didReachMovie = PassthroughSubject<Movie, Never>()
    
    private let columns = (0..<2).map { _ in GridItem(.flexible()) }

    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(movies) { movie in
                TrendingMovieItemView(movie: movie)
                    .onAppear {
                        didReachMovie.send(movie)
                    }
            }
        }
        .padding()
    }
}
