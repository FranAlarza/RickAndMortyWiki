//
//  APIPath.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 20/7/23.
//

import Foundation

enum APIPath {
    case characters
    case characterDetail(id: String)
    
    case locations
    
    var rawValue: String {
        switch self {
        case .characters: return "/api/character"
        case let .characterDetail(id): return "/api/character/\(id)"
        case .locations: return  "/api/location"
        }
    }
}
