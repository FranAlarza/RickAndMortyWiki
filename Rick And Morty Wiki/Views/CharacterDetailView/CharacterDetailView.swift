//
//  CharacterDetailView.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 20/7/23.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: CharactersResult
    var body: some View {
        ZStack {
            Text(character.name)
                .foregroundColor(.black)
                .opacity(0.1)
                .font(.system(size: 80))
                .bold()
            VStack {
                AsyncImage(url: URL(string: character.image)) { image in
                    image
                        .resizable()
                        .frame(width: 250, height: 250)
                        .cornerRadius(125)
                } placeholder: {
                    ProgressView()
                }
                HStack {
                    Text(character.name)
                        .foregroundColor(.yellowFeatureColor)
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                .padding()
                
                VStack(alignment: .leading) {
                    InfoLabel(feature: "Status", featureDescription: character.status, infoLabelType: .characters)
                    InfoLabel(feature: "Species", featureDescription: character.species, infoLabelType: .characters)
                    InfoLabel(feature: "Gender", featureDescription: character.gender, infoLabelType: .characters)
                    InfoLabel(feature: "Origine", featureDescription: character.origin.name, infoLabelType: .characters)
                    InfoLabel(feature: "Location", featureDescription: character.location.name, infoLabelType: .characters)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white, lineWidth: 2)
                )
                .cornerRadius(16)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.detailBlue)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image(.rmLetter)
                    .resizable()
                    .frame(width: 140, height: 60)
            }
        }
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView(character: .init(id: 1, name: "", status: "", species: "", type: "", gender: "", origin: Location(name: "", url: ""), location: Location(name: "", url: ""), image: "", episode: [], url: "", created: ""))
    }
}
