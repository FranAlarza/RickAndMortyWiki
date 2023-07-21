//
//  InfoLabel.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 21/7/23.
//

import SwiftUI

enum InfoLabelType {
    case characters
    case locations
}

struct InfoLabel: View {
    var feature: String
    var featureDescription: String
    var infoLabelType: InfoLabelType
    var body: some View {
        HStack {
            Text("\(feature):")
                .foregroundColor(infoLabelType == .characters ? .yellowFeatureColor : .pinkInfo)
            Text(featureDescription)
                .foregroundColor(infoLabelType == .characters ? .white : .greenInfo)
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
    }
}

struct InfoLabel_Previews: PreviewProvider {
    static var previews: some View {
        InfoLabel(feature: "Status", featureDescription: "Alive", infoLabelType: .locations)
    }
}
