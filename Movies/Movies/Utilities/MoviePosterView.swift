//
//  MoviePosterView.swift
//  Movies
//
//  Created by Waleed Saad on 07/01/2024.
//

import SwiftUI

struct MoviePosterView: View {
    
    let url: String?
    
    var body: some View {
        CacheAsyncImage(url: .init(string: url ?? "")) { phase in
            if let image = phase.image {
                image
                    .resizable()
            } else if phase.error != nil {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                HStack(alignment: .center) {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
        }
    }
}
