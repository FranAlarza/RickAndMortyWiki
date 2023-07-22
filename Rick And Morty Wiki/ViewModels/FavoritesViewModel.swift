//
//  FavoritesViewModel.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 22/7/23.
//

import Foundation

final class FavoritesViewModel: ObservableObject {
    
    @Published var favoritesCharacters: [CharactersResult] = []
    private var repository: Repository
    
    init(repository: Repository = AppRepository.shared) {
        self.repository = repository
    }
    
    func getFavoriteCharacters() {
        let favorites = repository.load(forKey: StorageKeys.KEY_FAVORITES, as: [CharactersResult].self)
        favoritesCharacters = favorites ?? []
    }
    
    func delete(at offsets: IndexSet) {
        var characters = favoritesCharacters
        characters.remove(atOffsets: offsets)
        repository.store(characters, key: StorageKeys.KEY_FAVORITES)
    }
}
