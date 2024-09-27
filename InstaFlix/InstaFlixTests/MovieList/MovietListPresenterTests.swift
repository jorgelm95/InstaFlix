//
//  MovietListPresenterTests.swift
//  InstaFlixTests
//
//  Created by Jorge Luis Menco Jaraba on 26/09/24.
//

import XCTest
@testable import InstaFlix
@testable import InstaFlixDomain

final class MovietListPresenterTests: XCTestCase {
    
    private var interactor: MovieListInteractorStub!
    private var viewSpy: MovieListViewSpy!
    private var routerSpy: MovieListRouterSpy!
    private var sut: MovieListPresenter!
    
    override func setUp() {
        super.setUp()
        interactor = MovieListInteractorStub(repository: MovieRepositoryStub())
        viewSpy = MovieListViewSpy()
        routerSpy = MovieListRouterSpy()
        sut = MovieListPresenter(
            interactor: interactor,
            view: viewSpy,
            showFavoritesMovies: false)
        sut.router = routerSpy
        interactor.presenter = sut
    }
    
    func test_fetchMovies_WhenShowFavoritesMovieIsNo_then_GetAllMovies() {
        //Given
        sut.shouldShouwFavoriteMovie = false
        
        //When
        sut.fetchMovies()
        
        //Then
        XCTAssertEqual(viewSpy.invoctations, [.removeLoadingView])
        XCTAssertEqual(viewSpy.movieListState, .filled)
        XCTAssertGreaterThan(viewSpy.items.count, 0)
    }
    
    func test_fetchMovies_WhenShowFavoritesMovieIsYes_then_GetFavoriteMovies() {
        //Given
        sut.shouldShouwFavoriteMovie = true
        
        //When
        sut.fetchMovies()
        
        //Then
        XCTAssertEqual(viewSpy.invoctations, [.removeLoadingView])
        XCTAssertEqual(viewSpy.movieListState, .filled)
        XCTAssertGreaterThan(viewSpy.items.count, 0)
    }
    
    func test_fetchMovies_WhenGetInvalidResponseError_then_ListStateIsEptyResult() {
        //Given
        interactor.setFailureResponse = true
        interactor.error = .invalidResponse
        
        //When
        sut.fetchMovies()
        
        //Then
        XCTAssertEqual(viewSpy.invoctations, [.removeLoadingView])
        XCTAssertEqual(viewSpy.movieListState, .emptyResults)
        XCTAssertEqual(viewSpy.items.count, 0)
    }
    
    func test_fetchMovies_WhenGeTUndefineError_then_ListStateIsNetworkrError() {
        
        //Given
        interactor.setFailureResponse = true
        interactor.error = .undefined
        
        //When
        sut.fetchMovies()
        
        //Then
        XCTAssertEqual(viewSpy.invoctations, [.removeLoadingView])
        XCTAssertEqual(viewSpy.movieListState, .NetworkError)
        XCTAssertEqual(viewSpy.items.count, 0)
    }
    
    func test_saveFavorite_WhenSaveFavoriteMovie_then_getShowAlertInfoCalled() {
        
        //Given
        let dummyData = DummyMovieData.movieData
        
        //When
        sut.saveFavorite(movie: dummyData)
        
        //Then
        XCTAssertEqual(viewSpy.invoctations, [.showInformativeAlert])
    }
    
    func test_goToMovieDeatil_TapInAnyMovie_then_SentToDetailMovie() {
        
        //Given
        let movie = DummyMovieData.movieData
        
        //When
        sut.goToMovieDetail(movie)
        
        //Then
        XCTAssertEqual(routerSpy.invocations, [.goToDetailMovie])
    }
}
