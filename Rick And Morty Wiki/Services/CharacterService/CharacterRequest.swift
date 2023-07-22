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
    case filteredCharacters(name: String)
}

extension CharactersRequest: APIRequest {
    var path: APIPath {
        switch self {
        case .characters, .filteredCharacters: return .characters
        case let .characterDetail(id): return .characterDetail(id: id)
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case let .characters(page):
            return [URLQueryItem(name: "page", value: page)]
        case .characterDetail:
            return nil
        case let .filteredCharacters(name):
            return [URLQueryItem(name: "name", value: name)]
        }
    }
}
