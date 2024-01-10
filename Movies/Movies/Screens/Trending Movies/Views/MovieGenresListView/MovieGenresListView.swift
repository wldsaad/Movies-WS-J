//
//  MovieGenresListView.swift
//  Movies
//
//  Created by Waleed Saad on 06/01/2024.
//

import SwiftUI
import Combine

struct MovieGenresListView: View {
    
    @Binding var genres: [Genre]
        
    var didTapGenre = PassthroughSubject<Genre, Never>()

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(genres) { genre in
                    MovieGenresListItemView(genre: genre)
                        .onTapGesture {
                            didTapGenre.send(genre)
                        }
                }
            }
            .padding(4)
        }
    }
}
