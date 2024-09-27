//
//  ServiceManagerMock.swift
//  
//
//  Created by Jorge Luis Menco Jaraba on 26/09/24.
//

import XCTest
import Combine
@testable import InstaFlixData
@testable import InstaFlixNetworking
@testable import InstaFlixDomain

final class ServiceManagerMock: ServiceManagerType {
    
    var isErrorExecution: Bool = false
    var errorExecution: ErrorHTTP.API = .undefined
    
    func execute<R>(_ request: R) -> AnyPublisher<R.Output, ErrorHTTP.API> where R : RequestType {
        
        if isErrorExecution {
            return Fail<R.Output, ErrorHTTP.API>(error: errorExecution).eraseToAnyPublisher()
        }
        
        return Future<R.Output, ErrorHTTP.API> { promise in
            promise(.success(
                ResponseResult<[APIMovie]>(
                    response: [
                        APIMovie(
                            id: 123,
                            adult: false,
                            originalTitle: "Allient",
                            overview: "While scavenging the deep ends of a derelict space station, a group of young space colonizers come face to face with the most terrifying life form in the universe",
                            releaseDate: "2024-08-13",
                            originalLanguage: "ES",
                            voteAverage: 6.45,
                            hasVideo: false,
                            posterPath: "https://image.tmdb.org/t/p/w1280/b33nnKl1GSFbao4l3fZDDqsMx0F.jpg")],
                    httpCode: 200)
                as! R.Output)
            )}.eraseToAnyPublisher()
    }
    
    func handleDataTaskOutput(urlResponse: URLResponse, data: Data) throws -> (httpCode: Int, data: Data) {
        return (200, Data())
    }
}
