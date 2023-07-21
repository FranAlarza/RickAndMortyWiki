//
//  Rick_and_Morty_WikiTests.swift
//  Rick and Morty WikiTests
//
//  Created by Francisco Javier Alarza on 20/7/23.
//

import XCTest
@testable import Rick_and_Morty_Wiki

@MainActor
class CharactersViewModelTests: XCTestCase {
    private var mockService: MockCharactersService!
    private var viewModel: CharactersViewModel!
    private var repository: MockRepository!

    override func setUp() {
        super.setUp()
        mockService = MockCharactersService()
        repository = MockRepository()
        viewModel = CharactersViewModel(service: mockService, repository: repository)
    }

    func testGetCharactersFetchesFromServiceWhenRepositoryIsEmpty() async throws {
        // Given
        let charactersResults = [CharactersResult(id: 1, name: "Test", status: "Alive", species: "Human", type: "", gender: "Male", origin: Location(name: "Earth", url: ""), location: Location(name: "Earth", url: ""), image: "", episode: [], url: "", created: "")]
        let charactersInfo = Info(count: 1, pages: 1, next: "", prev: nil)
        mockService.charactersResponse = Characters(info: charactersInfo, results: charactersResults)
        // When
        await viewModel.getCharacters(page: 1)
        // Then
        XCTAssertEqual(viewModel.characters.count, 1)
        XCTAssertEqual(viewModel.characters.first?.name, "Test")
    }

    func testGetCharactersLoadsFromRepositoryWhenDataIsAvailable() async throws {
        // Arrange
        var character: [CharactersResult] = []
        let charactersResults = CharactersResult(id: 1, name: "Test", status: "Alive", species: "Human", type: "", gender: "Male", origin: Location(name: "Earth", url: ""), location: Location(name: "Earth", url: ""), image: "", episode: [], url: "", created: "")
        (0...22).forEach { _ in
            character.append(charactersResults)
        }
        repository.store(character, key: StorageKeys.CHARACTERS_KEY)
        // Act
        await viewModel.getCharacters(page: 1)
        // Assert
        XCTAssertTrue(viewModel.characters.count > 20)
        XCTAssertEqual(viewModel.characters.first?.name, "Test")
    }
}
