//
//  MockCharactersService.swift
//  Rick and Morty WikiTests
//
//  Created by Francisco Javier Alarza on 21/7/23.
//

import Foundation

final class MockCharactersService: CharactersServiceProtocol {

    var charactersResponse: Characters?
    var error: Error?

    func getCharacters(request: CharactersRequest) async throws -> Characters {
        if let error = error {
            throw error
        }
        return charactersResponse ?? Characters(info: Info(count: 0, pages: 0, next: "", prev: ""), results: [])
    }
    
    func getCharacterDetail(request: CharactersRequest) async throws -> CharactersResult {
        return CharactersResult(id: 1, name: "Rick", status: "", species: "", type: "", gender: "", origin: Location(name: "", url: ""), location: Location(name: "", url: ""), image: "", episode: [], url: "", created: "")
    }
    
    func searchCharacter(request: CharactersRequest) async throws -> Characters {
        return Characters(info: Info(count: 0, pages: 0, next: "", prev: ""), results: [])
    }
}
