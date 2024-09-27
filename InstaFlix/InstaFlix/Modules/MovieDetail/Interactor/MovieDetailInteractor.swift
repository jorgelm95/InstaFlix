//
//  MovieDetailInteractor.swift
//  InstaFlix
//
//  Created by Jorge Luis Menco Jaraba on 26/09/24.
//

import Foundation
import InstaFlixDomain

final class MovieDetailInteractor: MovieDetailInteractorType {
    
    // MARK: - Internal properties -
    var repository: MoviesLocalStorageRepositoryTye

    // MARK: - LifeCycle -
    
    init(repository: MoviesLocalStorageRepositoryTye) {
        self.repository = repository
    }
    
    // MARK: - Internal methods -
    
    func saveFavorite(movie: InstaFlixDomain.Movie) {
        self.repository.addFavoriteMovie(movie: movie)
    }
}
