//
//  CharacterView.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 20/7/23.
//

import SwiftUI

struct CharacterView: View {
    @ObservedObject var vm: CharactersViewModel = CharactersViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                header
                characterSection
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(.rickIconTabbar)
                        .resizable()
                        .frame(width: 32, height: 32)
                }
            }
        }
        .task {
            await vm.getCharacters()
        }
    }
    
    var header: some View {
        VStack {
            Image(.rmHightlight)
                .resizable()
                .frame(width: 230, height: 170)
                .foregroundColor(.accentColor)
                .offset(x: 0, y: 25)
            Image(.rmPrincipal)
                .resizable()
                .frame(height: 170)
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
                HStack {
                    ForEach(vm.characters, id: \.id) { character in
                        CharacterCell(urlImage: character.image ?? "", nombre: character.name ?? "", specie: character.species ?? "", status: character.status ?? "")
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
