//
//  CharactersViewModel.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 20/7/23.
//

import Foundation

@MainActor
final class CharactersViewModel: ObservableObject {
    @Published var characters: [CharactersResult] = []
    @Published var charactersInLocations: [CharactersResult] = []
    @Published var searchedCharacters: [CharactersResult] = []
    @Published var charactersError: Bool = false
    @Published var charactersLocationsError: Bool = false
    @Published var searchCharactersError: Bool = false
    @Published var page: Int = 1
    
    private var storedCharacters: [CharactersResult] = []
    private let service: CharactersServiceProtocol
    private let repository: Repository
    
    init(service: CharactersServiceProtocol = CharactersService(), repository: Repository = AppRepository.shared) {
        self.service = service
        self.repository = repository
        //repository.delete(key: StorageKeys.CHARACTERS_KEY)
    }
    
    
    func getCharacters(page: Int) async {
        storedCharacters = loadCharactersFromRepository()
        print("\(storedCharacters.count)")
        if storedCharacters.count < 20 * page  {
            print("\(storedCharacters.count)")
            await fetchCharactersFromService(page: page)
        } else {
            self.page += 1
            characters = storedCharacters
        }
    }
    
    func searchCharacter(query: String) async throws {
        do {
            searchedCharacters = try await service.searchCharacter(request: .filteredCharacters(name: query)).results
            print("***** GetQuerySuccess *****:")
        } catch {
            searchCharactersError = true
        }
    }
    
    private func loadCharactersFromRepository() -> [CharactersResult] {
        return repository.load(forKey: StorageKeys.CHARACTERS_KEY, as: [CharactersResult].self) ?? []
    }
    
    private func isCharactersStored(id: Int) -> Bool {
        let maxCharacters = repository.load(forKey: StorageKeys.MAX_CHARACTERS_KEY, as: Int.self) ?? 0
        return id == storedCharacters.last?.id && storedCharacters.count == maxCharacters
    }
    
    private func calculateMaxStoredPage() -> Int {
        return (storedCharacters.count / 20) + 1
    }
    
    private func fetchCharactersFromService(page: Int) async {
        do {
            let charactersResponse = try await service.getCharacters(request: .characters(page: page.toString))
            self.page += 1
            charactersResponse.results.forEach { character in
                characters.append(character)
            }
            repository.store(charactersResponse.info.count, key: StorageKeys.MAX_CHARACTERS_KEY)
            repository.store(characters, key: StorageKeys.CHARACTERS_KEY)
            print("***** GetCharacterSuccess *****:")
        } catch {
            print("XXXXX GetCharacterError XXXXX: \(error.localizedDescription)")
            charactersError = true
        }
    }
    
    @MainActor
    func getResidents(residents: [String]) async {
        var ids: [String] = []
        residents.forEach { path in
            if let url = URL(string: path) {
                ids.append(url.lastPathComponent)
            }
        }
        print(ids)
        do {
            for id in ids {
                let result = try await service.getCharacterDetail(request: .characterDetail(id: id))
                charactersInLocations.append(result)
            }
        } catch {
            charactersLocationsError = true
        }
    }
    
}
