//
//  Rick_and_Morty_WikiTests.swift
//  Rick and Morty WikiTests
//
//  Created by Francisco Javier Alarza on 20/7/23.
//

import XCTest
@testable import Rick_and_Morty_Wiki

class CharactersViewModelTests: XCTestCase {
    private var mockService: MockCharactersService!
    private var viewModel: CharactersViewModel!

    override func setUp() {
        super.setUp()
        mockService = MockCharactersService()
        viewModel = CharactersViewModel(service: mockService)
    }

    func testGetCharactersSuccess() async throws {
        let expectedCharacters = [CharactersResult(id: 1, name: "Rick", status: "", species: "", type: "", gender: "", origin: Location(name: "", url: ""), location: Location(name: "", url: ""), image: "", episode: [], url: "", created: "")]
        mockService.charactersResponse = Characters(info: Info(count: 0, pages: 0, next: "", prev: ""), results: expectedCharacters)
        
        await viewModel.getCharacters(page: 1)

        XCTAssertTrue(viewModel.characters.count == 1)
        XCTAssertEqual(viewModel.page, 2)
        XCTAssertFalse(viewModel.CharactersError)
    }

    func testGetCharactersFailure() async {
        mockService.error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Test Error"])
        
        await viewModel.getCharacters(page: 1)

        XCTAssertTrue(viewModel.CharactersError)
        XCTAssertTrue(viewModel.characters.isEmpty)
    }
}
