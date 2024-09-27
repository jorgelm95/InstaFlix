//
//  FetchMoviesRepository.swift
//
//
//  Created by Jorge Luis Menco Jaraba on 25/09/24.
//

import Foundation
import Combine
import InstaFlixDomain
import InstaFlixNetworking
import RealmSwift

final public class FetchMoviesRepository: MovieRepository {
    let localStorageService: LocalStorageServiceType
    let serviceManager: ServiceManagerType
    let moviesMapperAdapater: MoviesMapperAdapater
    
    public init(
        serviceManager: ServiceManagerType,
        adapater: MoviesMapperAdapater,
        localStorageManager: LocalStorageServiceType) {
            self.serviceManager = serviceManager
            self.moviesMapperAdapater = adapater
            self.localStorageService = localStorageManager
        }
    
    public func fetchMovies() -> AnyPublisher<[InstaFlixDomain.Movie], FetchListMoviesError> {
        let request = FetchMoviesRequest()
        return serviceManager.execute(request)
            .map({ self.moviesMapperAdapater.mapMoviesToDomainModel(apiData: $0.response) })
            .mapError({ self.mapperError(error: $0) })
            .eraseToAnyPublisher()
    }
    
    private func mapperError(error: ErrorHTTP.API) -> FetchListMoviesError {
        switch error {
        case .invalidResponse:
            return .invalidResponse
        case .undefined:
            return .undefined
        }
    }
    
    public func addFavoriteMovie(movie: Movie) {
        let localMovie = LocalMovie()
        localMovie.id = movie.id
        localMovie.adult = movie.adult
        localMovie.originalTitle = movie.originalTitle
        localMovie.originalLanguage = movie.originalLanguage
        localMovie.overview = movie.overview
        localMovie.hasVideo = movie.hasVideo
        localMovie.posterPath = movie.posterPath
        localMovie.releaseDate = movie.releaseDate
        localMovie.voteAverage = movie.voteAverage
        
        localStorageService.addMovie(movie: localMovie)
    }
    
    public func fetchFavoriteMovies() -> [Movie] {
        let result = localStorageService.fetchFavoriteMovies()
        let favoritesMovies: [Movie] = result.compactMap({ item in
            Movie(
                id: item.id,
                adult: item.adult,
                originalTitle: item.originalTitle,
                overview: item.overview,
                releaseDate: item.releaseDate,
                originalLanguage: item.originalLanguage,
                voteAverage: item.voteAverage,
                hasVideo: item.hasVideo,
                posterPath: item.posterPath)
        })
        
        return favoritesMovies
    }
}
