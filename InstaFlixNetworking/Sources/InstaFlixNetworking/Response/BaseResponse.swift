//
//  File.swift
//  
//
//  Created by Jorge Luis Menco Jaraba on 25/09/24.
//

import Foundation

// The response protocol define a contract with base properties for a response

public protocol ResponseType {
    associatedtype Response
    var response: Response { get }
    var httpCode: Int { get }
    init(response: Response, httpCode: Int)
}

public struct ResponseResult<R: Decodable>: ResponseType {
    
    public var httpCode: Int
    public typealias Response = R
    
    public var response: Response
    
    public init(response: Response, httpCode: Int) {
        self.response = response
        self.httpCode = httpCode
    }
}
