//
//  NetworkRequester.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 20/7/23.
//

import Foundation

struct NetworkRequester {
    private let session: URLSession

    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    func requestService<T: Decodable>(_ request: NetworkRequest) async throws -> T {
        let (data, urlResponse) = try await session.data(from: request.request.url!)

        if let urlResponse = urlResponse as? HTTPURLResponse {
            switch urlResponse.statusCode {
            case 400...530:
                let apiError = try mapResponse(data: data, dataType: APIError.self)
                throw apiError
            default: break
            }
        }
        
        let mappedResponse = try JSONDecoder().decode(T.self, from: data)
        return mappedResponse
    }

    private func printJSON(data: Data) throws {
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        print("JSON: \(json)")
    }

    private func mapResponse<T: Decodable>(data: Data, dataType: T.Type) throws -> T {
        let decoder = JSONDecoder()
        try printJSON(data: data)
        return try decoder.decode(T.self, from: data)
    }
}

extension NetworkRequester {
    func doRequest<T: Decodable>(request: APIRequest) async throws -> T {
        let networkRequest = NetworkRequest(apiRequest: request)
        let response: T = try await requestService(networkRequest)
        return response
    }
}
