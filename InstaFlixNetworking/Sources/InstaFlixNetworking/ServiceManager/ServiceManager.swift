//
//  File.swift
//  
//
//  Created by Jorge Luis Menco Jaraba on 25/09/24.
//

import Foundation
import Combine

// ServiceManagerType is a protocol that define the contract for execute calls to the API
public protocol ServiceManagerType: AnyObject {
    func execute<R: RequestType>(_ request: R) -> AnyPublisher<R.Output, ErrorHTTP.API>
    func handleDataTaskOutput(
        urlResponse: URLResponse,
        data: Data
    ) throws -> (httpCode: Int, data: Data)
}

public final class ServiceManager: NSObject, ServiceManagerType {
    
    public override init() {}
    
    // Method for make a HTTP resource wint a resquest as input parameter
    
    public func execute<R>(_ request: R) -> AnyPublisher<R.Output, ErrorHTTP.API> where R : RequestType {
        do {
            let urlRequest = try request.buildRequest()
            return getSession()
                .dataTaskPublisher(for: urlRequest)
                .tryMap { try self.handleDataTaskOutput(
                    urlResponse: $0.response,
                    data: $0.data)}
                .tryMap { try request.decode(data: $0.data, httpCode: $0.httpCode) }
                .mapError { self.handleDataTaskError($0) }
                .subscribe(on: OperationQueue())
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        } catch {
            return Fail<R.Output, ErrorHTTP.API>(error: error as? ErrorHTTP.API ?? .undefined).eraseToAnyPublisher()
        }
    }

    // Method for handle the data that return the data task publisher
    
    public func handleDataTaskOutput(urlResponse: URLResponse, data: Data) throws -> (httpCode: Int, data: Data) {
        guard let httpURLResponse = urlResponse as? HTTPURLResponse
        else {
            throw ErrorHTTP.API.invalidResponse
        }

        return (httpURLResponse.statusCode, data)
    }
    
    private func handleDataTaskError(
        _ error: Error
    ) -> ErrorHTTP.API {
        if let error = error as? URLError, error.code != .timedOut {
            return ErrorHTTP.API.undefined
        }
        return error as? ErrorHTTP.API ?? .undefined
    }
    
    func getSession() -> URLSession {
        URLSession(
            configuration: URLSessionConfiguration.default,
            delegate: self,
            delegateQueue: .main
        )
    }
}

// Extension for create a trust URLSession and make HTTP request to public API
// MARK: - Private properties -

extension ServiceManager: URLSessionDelegate {
    public func urlSession(
        _ session: URLSession,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
    ) {
        if let serverTrust = challenge.protectionSpace.serverTrust {
            completionHandler(.useCredential, URLCredential(trust: serverTrust))
        }
    }
}
