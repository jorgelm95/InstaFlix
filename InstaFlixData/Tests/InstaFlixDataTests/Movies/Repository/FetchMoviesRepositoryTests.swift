//
//  FetchMoviesRepositoryTests.swift
//
//
//  Created by Jorge Luis Menco Jaraba on 26/09/24.
//

import XCTest
@testable import InstaFlixData
@testable import InstaFlixDomain

final class FetchMoviesRepositoryTests: XCTestCase {
    
    private var localStorageService: LocalStorageServiceType!
    private var serviceManager: ServiceManagerMock!
    private var moviesMapperAdapater: MoviesMapperAdapater!
    
    private var sut: FetchMoviesRepository!
    
    override func setUp() {
        super.setUp()
        serviceManager = ServiceManagerMock()
        localStorageService = LocalStorageServiceManagerMock()
        sut = FetchMoviesRepository(
            serviceManager: serviceManager,
            adapater: MoviesMapperAdapater(),
            localStorageManager: localStorageService)
    }
    
    override func tearDown() {
        super.tearDown()
        serviceManager = nil
        sut = nil
    }
    
    func test_FetchMovies_WhenServiceReturnOk_then_GetMovies() {
        //Given
        let expectation = XCTestExpectation(description: "request for get movies")
        
        //When
        
        _ = sut.fetchMovies().sink { completion in
            switch completion {
            case .finished:
                expectation.fulfill()
                break
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        } receiveValue: { result in
            //Then
            XCTAssertGreaterThan(result.count, 0)
        }
        
        wait(for: [expectation])
    }
    
    func test_FetchMovies_WhenServiceReturnEror_then_Success() {
        //Given
        serviceManager.isErrorExecution = true
        let expectation = XCTestExpectation(description: "request for get movies")
        
        //When
        
        _ = sut.fetchMovies().sink { completion in
            switch completion {
            case .finished:
                expectation.fulfill()
                break
            case .failure(let error):
                expectation.fulfill()
                XCTAssertNotNil(error)
            }
        } receiveValue: { result in
            //Then
            XCTFail()
        }
        
        wait(for: [expectation])
    }
    
    func test_FetchFavoritesMovies_WhenGetFavoriesMoviesinLocal_then_GetMovies() {
        
        //When
        sut.addFavoriteMovie(movie: DummyMovieData.movieData)
        
        let movies = sut.fetchFavoriteMovies()
        
        //Then
        XCTAssertGreaterThan(movies.count, 0)
    }
    
    func test_SaveFavoriteMovie_WhenGetFavoriesMoviesinLocal_then_GetMovies() {
        
        //Given
        let dummyMovie = DummyMovieData.movieData
        
        //When
        sut.addFavoriteMovie(movie: dummyMovie)
        
        //Then
        let result = self.localStorageService.fetchFavoriteMovies()
        XCTAssertGreaterThan(result.count, 0)
    }
}

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
