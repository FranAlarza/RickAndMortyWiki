//
//  CharacterCell.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 20/7/23.
//

import SwiftUI

struct CharacterCell: View {
    let urlImage: String
    let nombre: String
    let specie: String
    let status: String
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: urlImage)) { image in
                image
                    .resizable()
                    .frame(width: 150)
                    .frame(maxHeight: .infinity)
                    .cornerRadius(16)
                    .padding(.horizontal, 16)
            } placeholder: {
                Rectangle()
                    .frame(width: 150)
                    .frame(maxHeight: .infinity)
                    .cornerRadius(16)
                    .padding()
            }
            Text(nombre)
                .bold()
                .foregroundColor(.black)
            Text("\(specie), \(status)")
                .font(.caption)
                .foregroundColor(.black)
        }
    }
}

struct CharacterCell_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCell(urlImage: "https://rickandmortyapi.com/api/character/avatar/361.jpeg", nombre: "Toxic Rick", specie: "Humanoid", status: "Dead")
    }
}
