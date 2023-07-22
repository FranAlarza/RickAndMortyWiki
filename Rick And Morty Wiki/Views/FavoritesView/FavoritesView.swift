//
//  FavoritesView.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 22/7/23.
//

import SwiftUI

struct FavoritesView: View {
    @State var favoritesCharacters: [CharactersResult] = FavoriteManager.shared.loadFavorites()
    var body: some View {
        ScrollView {
            VStack {
                ForEach(favoritesCharacters) { character in
                    HStack {
                        AsyncImage(url: URL(string: character.image)) { image in
                            image
                                .resizable()
                                .frame(width: 100, height: 100)
                                .cornerRadius(50)
                        } placeholder: {
                            ProgressView()
                        }
                        Text(character.name)
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image(.rickIconTabbar)
                    .resizable()
                    .frame(width: 32, height: 32)
            }
            
            ToolbarItem(placement: .principal) {
                Image(.rmLetter)
                    .resizable()
                    .frame(width: 140, height: 60)
            }
    }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
