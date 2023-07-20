//
//  NetworkRequest.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 20/7/23.
//

import Foundation

struct NetworkRequest {
    
    var request: URLRequest
    
    init(apiRequest: APIRequest) {

        var urlComponents = URLComponents(string: apiRequest.url?.description ?? "")
        urlComponents?.path = apiRequest.path.rawValue
        urlComponents?.queryItems = apiRequest.queryItems

        guard let fullURL = urlComponents?.url else {
            assertionFailure("Couldn't build the URL")
            self.request = URLRequest(url: URL(string: "")!)
            return
        }

        print("NetworkRequester URL - ", fullURL)
        request = URLRequest(url: fullURL)
        request.httpMethod = apiRequest.method.rawValue
        
    }
}
