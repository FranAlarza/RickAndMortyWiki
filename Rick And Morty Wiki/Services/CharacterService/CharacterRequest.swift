//
//  CharacterRequest.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 20/7/23.
//

import Foundation

enum CharactersRequest {
    case characters
}

extension CharactersRequest: APIRequest {
    var path: APIPath {
        switch self {
        case .characters: return .characters
        }
    }
}
