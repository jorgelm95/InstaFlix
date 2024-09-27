//
//  FetchMoviesRequest.swift
//
//
//  Created by Jorge Luis Menco Jaraba on 25/09/24.
//

import Foundation
import InstaFlixNetworking

struct FetchMoviesRequest: RequestType {
    
    typealias Output = ResponseResult<[APIMovie]>
    
    var baseUrl: URL { URL(string: "https://run.mocky.io/")! }
    var path: String { "v3/237fc551-d059-4aee-993a-064684842627" }
    var queryParams: HTTPQueryParams {[:]}
    var method: HTTPMethod { .get }
    
    func decode(data: Data, httpCode: Int) throws -> ResponseResult<[APIMovie]> {
        let decoder = JSONDecoder()

        printData(for: data)
        
        return Output(
            response: try decoder.decode(Output.Response.self, from: data),
            httpCode: httpCode)
    }
    
    private func printData(for data: Data) {
        guard let json = getJsonResponse(for: data) else {
            return
        }
        debugPrint("[HTTP RESPONSE] ", json)
    }
    
    private func getJsonResponse(for data: Data) -> Dictionary<String, Any>? {
        
        let object = try? JSONSerialization.jsonObject(with: data)
        let prettyPrintedData = try? JSONSerialization.data(
            withJSONObject: object,
            options: [.prettyPrinted, .sortedKeys]
        )
        let prettyPrintedString = String(data: prettyPrintedData!, encoding: .utf8)!
        print(prettyPrintedString)
        
//        return object as? [String: Any]
        
        return try? JSONSerialization.jsonObject(with: prettyPrintedData!, options: []) as? [String: Any]
    }
}
