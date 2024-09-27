//
//  APIMovie.swift
//
//
//  Created by Jorge Luis Menco Jaraba on 25/09/24.
//

import Foundation
import Combine
import InstaFlixNetworking
import InstaFlixDomain

public struct APIMovie: Decodable {
    public let id: Int
    public let adult: Bool
    public let originalTitle: String
    public let overview: String
    public let releaseDate: String
    public let originalLanguage: String
    public let voteAverage: Double
    public let hasVideo: Bool
    public let posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case id, adult, overview
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
        case voteAverage = "vote_average"
        case hasVideo = "video"
        case posterPath = "poster_path"
    }
}

public struct FetchMoviesResponse: Decodable {
    let results: [APIMovie]
}
