//
//  MoviesMapperAdapaterAble.swift
//
//
//  Created by Jorge Luis Menco Jaraba on 25/09/24.
//

import Foundation
import InstaFlixDomain

public protocol MoviesMapperAdapaterAble {
    func mapMoviesToDomainModel(apiData: [APIMovie]) -> [Movie]
}

public final class MoviesMapperAdapater: MoviesMapperAdapaterAble {
    
    public init() {}
    
    public func mapMoviesToDomainModel(apiData: [APIMovie]) -> [Movie] {
        let result = apiData.compactMap { movie in
            Movie(
                id: movie.id,
                adult: movie.adult,
                originalTitle: movie.originalTitle,
                overview: movie.overview,
                releaseDate: movie.releaseDate,
                originalLanguage: movie.originalLanguage,
                voteAverage: String(format: "%.3f", movie.voteAverage),
                hasVideo: movie.hasVideo,
                posterPath: movie.posterPath)
        }
        return result
    }
}
