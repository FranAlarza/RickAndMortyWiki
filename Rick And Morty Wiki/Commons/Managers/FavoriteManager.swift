//
//  FavoriteManager.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 22/7/23.
//

import Foundation

final class FavoriteManager: ObservableObject {
    
    @Published var favorites: [CharactersResult] = []
    static let shared = FavoriteManager()
    
    private init() {
        loadFavorites()
    }
    
    func saveFavorite(character: CharactersResult) {
        favorites.append(character)
        AppRepository.shared.store(favorites, key: StorageKeys.KEY_FAVORITES)
        print("item stored: \(character.name)")
    }
    
    func loadFavorites() {
        favorites = AppRepository.shared.load(forKey: StorageKeys.KEY_FAVORITES, as: [CharactersResult].self) ?? []
    }
    
    func checkIfIsFavorite(character: CharactersResult) -> Bool {
        return favorites.contains(where: {$0.id == character.id})
    }
    
    func deleteFavorite(character: CharactersResult) {
        favorites.removeAll(where: {$0.id == character.id})
        AppRepository.shared.store(favorites, key: StorageKeys.KEY_FAVORITES)
        print("item deleted: \(character.name)")
    }
}
