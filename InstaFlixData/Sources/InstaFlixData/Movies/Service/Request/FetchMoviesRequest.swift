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
    var path: String { "v3/fff7d39b-2e8d-46c8-aae3-9f14fd3e929b" }
    var queryParams: HTTPQueryParams {[:]}
    var method: HTTPMethod { .get }
    
    func decode(data: Data, httpCode: Int) throws -> ResponseResult<[APIMovie]> {
        let decoder = JSONDecoder()

        if  !data.isEmpty {
            printData(for: data)
            return Output(
                response: try decoder.decode(Output.Response.self, from: data),
                httpCode: httpCode)
        } else {
            return  ResponseResult<[APIMovie]>(response: [], httpCode: httpCode)
        }
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
        
        return try? JSONSerialization.jsonObject(with: prettyPrintedData!, options: []) as? [String: Any]
    }
}
