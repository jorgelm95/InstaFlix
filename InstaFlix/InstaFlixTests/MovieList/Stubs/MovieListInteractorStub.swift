//
//  MovieListInteractorStub.swift
//  InstaFlixTests
//
//  Created by Jorge Luis Menco Jaraba on 26/09/24.
//

import Foundation
@testable import InstaFlix
@testable import InstaFlixDomain


final class MovieListInteractorStub: MovieListInteractorType {
    
    var setFailureResponse: Bool  = false
    var error: FetchListMoviesError?
    var presenter: MovieIntInteractorOuputType?
    
    var repository: MovieRepository
    
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func fetchMovies() {
        if setFailureResponse {
            presenter?.manageRequestError(error: error ?? .undefined)
        } else {
            presenter?.showMovies([DummyMovieData.movieData])
        }
    }
    
    func fetchFavoriesMovies() {
        if setFailureResponse {
            presenter?.manageRequestError(error: error ?? .undefined)
        } else {
            presenter?.showMovies([DummyMovieData.movieData])
        }
    }
    
    func saveFavorite(movie: InstaFlixDomain.Movie) {
        presenter?.showAlert()
    }
}
