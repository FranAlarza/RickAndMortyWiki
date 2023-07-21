//
//  LocationRequest.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 21/7/23.
//

import Foundation

enum LocationsRequest {
    case locations(page: String)
}

extension LocationsRequest: APIRequest {
    var path: APIPath {
        switch self {
        case .locations: return .locations
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case let .locations(page):
            return [URLQueryItem(name: "page", value: page)]
        }
    }
}
