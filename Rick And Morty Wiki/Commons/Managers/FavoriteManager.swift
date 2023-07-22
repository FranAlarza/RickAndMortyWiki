//
//  FavoriteManager.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 22/7/23.
//

import Foundation

final class FavoriteManager {
    
    static let shared = FavoriteManager()
    
    private init() {}
    
    func saveFavorite(character: CharactersResult) {
        if var favorites = AppRepository.shared.load(forKey: StorageKeys.KEY_FAVORITES, as: [CharactersResult].self) {
            favorites.append(character)
            AppRepository.shared.store(favorites, key: StorageKeys.KEY_FAVORITES)
            print("item stored: \(character.name)")
        }
    }
    
    func loadFavorites() -> [CharactersResult] {
        return AppRepository.shared.load(forKey: StorageKeys.KEY_FAVORITES, as: [CharactersResult].self) ?? []
    }
    
    func checkIfIsFavorite(character: CharactersResult) -> Bool {
        let favorites = loadFavorites()
        return favorites.contains(where: {$0.id == character.id})
    }
    
    func deleteFavorite(character: CharactersResult) {
        var favorites = loadFavorites()
        favorites.removeAll(where: {$0.id == character.id})
        AppRepository.shared.store(favorites, key: StorageKeys.KEY_FAVORITES)
    }
}
