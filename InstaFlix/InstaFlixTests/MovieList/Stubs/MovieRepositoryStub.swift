//
//  MovieRepositoryStub.swift
//  InstaFlixTests
//
//  Created by Jorge Luis Menco Jaraba on 26/09/24.
//

import Foundation
import Combine
@testable import InstaFlixDomain


final class MovieRepositoryStub: MovieRepository {
    
    var setFailureResponse: Bool  = false
    var error: FetchListMoviesError?
    
    func addFavoriteMovie(movie: Movie) {
        //Todo mock implementation
    }
    
    func fetchFavoriteMovies() -> [Movie] {
        return []
    }
    
    func fetchMovies() -> AnyPublisher<[Movie], FetchListMoviesError> {
        if setFailureResponse {
            return Fail<[Movie], FetchListMoviesError>(error: error ?? .undefined).eraseToAnyPublisher()
        } else {
            return Future<[Movie], FetchListMoviesError> { promise in
                promise(.success([DummyMovieData.movieData]))
            }.eraseToAnyPublisher()
        }
    }
}
