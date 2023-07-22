//
//  CharacterView.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 20/7/23.
//

import SwiftUI

struct CharacterView: View {
    @ObservedObject var vm: CharactersViewModel = CharactersViewModel()
    @State var query: String = ""
    var body: some View {
        NavigationStack {
            VStack {
                header
                characterSection
            }
            .background(Color.backgroundBlue)
            .task {
                await vm.getCharacters(page: vm.page)
            }
            .searchable(text: $query) {
                ForEach(vm.searchedCharacters) { sugestion in
                    NavigationLink {
                        CharacterDetailView(character: sugestion)
                    } label: {
                        HStack(spacing: 16) {
                            AsyncImage(url: URL(string: sugestion.image)) { image in
                                image
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(25)
                            } placeholder: {
                                ProgressView()
                            }
                            Text(sugestion.name)
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            .onChange(of: query, perform: { newValue in
                Task {
                    try await vm.searchCharacter(query: newValue)
                }
        })
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image(.rmLetter)
                        .resizable()
                        .frame(width: 140, height: 60)
                }
            }
        }
    }
    
    var header: some View {
        VStack {
            Image(.rmHightlight)
                .resizable()
                .frame(width: 230, height: 130)
                .foregroundColor(.accentColor)
                .offset(x: 0, y: 25)
            Image(.rmPrincipal)
                .resizable()
                .frame(height: 140)
                .cornerRadius(16)
                .padding()
            
        }
    }
    
    var characterSection: some View {
        VStack {
            HStack {
                Text("Characters")
                    .foregroundColor(.mainBlue)
                    .font(.title2)
                    .bold()
                Spacer()
            }
            .padding(.horizontal, 16)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(vm.characters, id: \.id) { character in
                        NavigationLink {
                            CharacterDetailView(character: character)
                        } label: {
                            CharacterCell(urlImage: character.image, nombre: character.name, specie: character.species, status: character.status)
                                .onAppear {
                                    if (vm.characters.isLast(character) || character.id % 20 == 0) {
                                        Task {
                                            await vm.getCharacters(page: vm.page)
                                        }
                                    }
                                }
                        }
                    }
                }
            }
            
        }
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView()
    }
}
