//
//  TrendingMovieItemView.swift
//  Movies
//
//  Created by Waleed Saad on 06/01/2024.
//

import SwiftUI

struct TrendingMovieItemView: View {
    
    let movie: Movie
    
    var body: some View {
        
        VStack(spacing: 0) {
            MoviePosterView(url:movie.thumbnail)
                .frame(height: 200)
            
            Spacer()
            
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text(movie.title)
                        .lineLimit(2, reservesSpace: true)
                        .font(.footnote)
                        .bold()
                    Text(movie.releaseDate)
                        .lineLimit(1)
                        .font(.caption2)
                }
                .multilineTextAlignment(.leading)
                .foregroundStyle(Color.primary)
                .minimumScaleFactor(0.5)
                .layoutPriority(1)
                
                Spacer()
            }
            .padding(4)
        }
        .background {
            Color.secondary
                .opacity(0.1)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}
