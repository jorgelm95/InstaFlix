//
//  MoviesDummyData.swift
//  InstaFlixTests
//
//  Created by Jorge Luis Menco Jaraba on 26/09/24.
//

import Foundation
@testable import InstaFlix
@testable import InstaFlixDomain

struct DummyMovieData {
    
    static let movieData: Movie = {
        return Movie(
            id: 123,
            adult: false,
            originalTitle: "Allient",
            overview: "While scavenging the deep ends of a derelict space station, a group of young space colonizers come face to face with the most terrifying life form in the universe",
            releaseDate: "2024-08-13",
            originalLanguage: "ES",
            voteAverage: "6.45",
            hasVideo: false,
            posterPath: "https://image.tmdb.org/t/p/w1280/b33nnKl1GSFbao4l3fZDDqsMx0F.jpg")
    }()
}
