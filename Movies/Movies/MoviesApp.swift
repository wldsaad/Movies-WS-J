//
//  MoviesApp.swift
//  Movies
//
//  Created by Waleed Saad on 04/01/2024.
//

import SwiftUI
import SwiftData

@main
struct MoviesApp: App {
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Movie.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            TrendingMoviesView<TrendingMoviesViewModel>(
                viewModel: TrendingMoviesViewModelFactory().viewModel
            )
        }
        .modelContainer(sharedModelContainer)
    }
}
