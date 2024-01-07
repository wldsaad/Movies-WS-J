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
            Genre.self,
            MovieDetails.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().compactScrollEdgeAppearance = appearance
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                TrendingMoviesView<TrendingMoviesViewModel>(
                    viewModel: TrendingMoviesViewModelFactory().viewModel
                )
                .navigationDestination(for: Movie.self) { movie in
                    MovieDetailsView(viewModel: MovieDetailsViewModelFactory().viewModel(movieId: movie.movieId))
                }
            }
        }
        .modelContainer(sharedModelContainer)
    }
}

extension UINavigationController: UINavigationControllerDelegate {

    open override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
    }
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.backButtonTitle = " "
    }
}
