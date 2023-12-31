//
//  FavoritesView.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 22/7/23.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var vm: FavoriteManager
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                if vm.favorites.count != 0 {
                    LazyVGrid(columns: columns) {
                        ForEach(vm.favorites) { character in
                            NavigationLink {
                                CharacterDetailView(character: character)
                            } label: {
                                AsyncImage(url: URL(string: character.image)) { image in
                                    image
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(50)
                                        .contextMenu {
                                            Button {
                                                FavoriteManager.shared.deleteFavorite(character: character)
                                            } label: {
                                                Text("Eliminar")
                                                Image(systemName: "trash")
                                            }
                                            
                                        }
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                    }
                } else {
                    VStack {
                        Spacer()
                        Image(.rmEmptyView)
                            .resizable()
                            .frame(width: 200, height: 300)
                        Text("Upsss...Any favorites yet")
                        Spacer()
                    }
                }
            }
            .frame(width: .infinity, height: .infinity)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image(.rmLetter)
                        .resizable()
                        .frame(width: 140, height: 60)
                }
            }
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
