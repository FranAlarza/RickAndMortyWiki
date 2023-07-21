//
//  CharacterRequest.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 20/7/23.
//

import Foundation

enum CharactersRequest {
    case characters(page: String)
    case characterDetail(id: String)
}

extension CharactersRequest: APIRequest {
    var path: APIPath {
        switch self {
        case .characters: return .characters
        case let .characterDetail(id): return .characterDetail(id: id)
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case let .characters(page):
            return [URLQueryItem(name: "page", value: page)]
        case .characterDetail:
            return nil
        }
    }
}
