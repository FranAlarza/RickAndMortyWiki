//
//  APIRequest.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 20/7/23.
//

import Foundation

protocol APIRequest {
    var url: URL? { get }
    var path: APIPath { get }
    var queryItems: [URLQueryItem]? { get }
    var method: HTTPMethod { get }
}

extension APIRequest {
    // Default values
    var url: URL? { ServiccesURL.baseURL.convertedURL }
    var queryItems: [URLQueryItem]? { nil }
    var method: HTTPMethod { .get }
}
