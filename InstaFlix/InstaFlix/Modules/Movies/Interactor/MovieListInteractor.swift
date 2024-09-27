//
//  MovieListInteractor.swift
//  InstaFlix
//
//  Created by Jorge Luis Menco Jaraba on 25/09/24.
//

import Foundation
import Combine
import InstaFlixDomain

final class MovieListInteractor: MovieListInteractorType {
    
    // MARK: - Private properties -
    
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Internal properties -
    
    weak var presenter: MovieIntInteractorOuputType?
    var repository: MovieRepository
    
    // MARK: - LifeCycle -
    
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    // MARK: - Internal methods -
    
    func fetchMovies() {
        self.repository.fetchMovies().sink { [weak self] completion in
            guard let self else { return }
            switch completion {
            case .finished:
                break
            case .failure(let error):
                self.presenter?.manageRequestError(error: error)
            }
        } receiveValue: { [weak self] result in
            guard let self else { return }
            self.presenter?.showMovies(result)
        }.store(in: &cancellable)
    }
    
    func fetchFavoriesMovies() {
        let favoriteMovies = self.repository.fetchFavoriteMovies()
        self.presenter?.showMovies(favoriteMovies)
    }
    
    func saveFavorite(movie: Movie) {
        self.repository.addFavoriteMovie(movie: movie)
        self.presenter?.showAlert()
    }
}
