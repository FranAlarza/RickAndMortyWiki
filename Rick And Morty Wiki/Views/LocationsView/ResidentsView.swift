//
//  ResidentsView.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 21/7/23.
//

import SwiftUI

struct ResidentsView: View {
    @EnvironmentObject var vm: CharactersViewModel
    @State var isLoaded = false
    let paths: [String]
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                if isLoaded {
                    ForEach(vm.charactersInLocations) { resident in
                        NavigationLink {
                            CharacterDetailView(character: resident)
                        } label: {
                            CharacterCell(urlImage: resident.image, nombre: resident.name, specie: resident.species, status: resident.status)
                                .frame(height: 150)
                        }
                    }
                    
                } else {
                    ProgressView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image(.rmLetter)
                        .resizable()
                        .frame(width: 140, height: 60)
                }
            }
        }
        .onAppear {
            Task {
                await vm.getResidents(residents: paths)
                isLoaded = true
            }
            
        }
    }
}

struct ResidentsView_Previews: PreviewProvider {
    static var previews: some View {
        ResidentsView(paths: [])
    }
}
