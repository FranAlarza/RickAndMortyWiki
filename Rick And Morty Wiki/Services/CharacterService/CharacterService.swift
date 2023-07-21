//
//  CharacterService.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 20/7/23.
//

import Foundation

protocol CharactersServiceProtocol {
    func getCharacters(request: CharactersRequest) async throws -> Characters
    func getCharacterDetail(request: CharactersRequest) async throws -> CharactersResult
}

final class CharactersService: CharactersServiceProtocol {
    
    let networkRequester: NetworkRequester
    
    init(networkRequester: NetworkRequester = .init()) {
        self.networkRequester = networkRequester
    }
    
    func getCharacters(request: CharactersRequest) async throws -> Characters {
        try await networkRequester.doRequest(request: request)
    }
    
    func getCharacterDetail(request: CharactersRequest) async throws -> CharactersResult {
        try await networkRequester.doRequest(request: request)
    }
}
