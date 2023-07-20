//
//  CharactersViewModel.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 20/7/23.
//

import Foundation

final class CharactersViewModel: ObservableObject {
    @Published var characters: [CharactersResult] = []
    @Published var CharactersError: Bool = false
    
    let service: CharactersService
    
    init(service: CharactersService = CharactersService()) {
        self.service = service
    }
    
    func getCharacters() async {
        do {
            characters = try await service.getCharacters(request: .characters).results
            print("***** GetCharacterError *****: \(characters)")
        } catch {
            print("XXXXX GetCharacterError XXXXX: \(error.localizedDescription)")
        }
       
    }
}
