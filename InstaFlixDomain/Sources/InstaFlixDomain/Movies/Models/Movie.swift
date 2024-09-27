//
//  Movie.swift
//
//
//  Created by Jorge Luis Menco Jaraba on 25/09/24.
//

import Foundation
import Combine

public struct Movie {
    public let id: Int
    public let adult: Bool
    public let originalTitle: String
    public let overview: String
    public let releaseDate: String
    public let originalLanguage: String
    public let voteAverage: String
    public let hasVideo: Bool
    public let posterPath: String
    
    public init(id: Int, adult: Bool, originalTitle: String, overview: String, releaseDate: String, originalLanguage: String, voteAverage: String, hasVideo: Bool, posterPath: String) {
        self.id = id
        self.adult = adult
        self.originalTitle = originalTitle
        self.overview = overview
        self.releaseDate = releaseDate
        self.originalLanguage = originalLanguage
        self.voteAverage = voteAverage
        self.hasVideo = hasVideo
        self.posterPath = posterPath
    }
}
