//
//  MoviesRepositoryType.swift
//
//
//  Created by Jorge Luis Menco Jaraba on 25/09/24.
//

import Foundation
import Combine

public typealias MovieRepository = MoviesRepositoryType & MoviesLocalStorageRepositoryTye

public protocol MoviesRepositoryType: AnyObject {
    func fetchMovies() -> AnyPublisher<[Movie], FetchListMoviesError>
}

public protocol MoviesLocalStorageRepositoryTye {
    func addFavoriteMovie(movie: Movie)
    func fetchFavoriteMovies() -> [Movie]
}
