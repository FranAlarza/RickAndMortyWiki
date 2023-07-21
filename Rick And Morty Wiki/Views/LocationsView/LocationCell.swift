//
//  LocationCell.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 21/7/23.
//

import SwiftUI

struct LocationCell: View {
    var location: LocationsResult
    var body: some View {
        VStack {
            Text(location.name)
                .foregroundColor(.detailBlue)
                .bold()
                .font(.title2)
            InfoLabel(feature: "Type", featureDescription: location.type, infoLabelType: .locations)
            InfoLabel(feature: "Dimension", featureDescription: location.dimension, infoLabelType: .locations)
            InfoLabel(feature: "Number Of Residents", featureDescription: location.residents.count.toString, infoLabelType: .locations)
            NavigationLink {
                ResidentsView(paths: location.residents)
                    .environmentObject(CharactersViewModel())
            } label: {
                Text("See Residents")
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.mainBlue, lineWidth: 2)
        )
        .cornerRadius(16)
    }
}

struct LocationCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationCell(location: LocationsResult(id: 1, name: "", type: "", dimension: "", residents: [], url: "", created: ""))
    }
}
