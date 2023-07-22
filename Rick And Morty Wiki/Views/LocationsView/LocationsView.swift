//
//  LocationsView.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 21/7/23.
//

import SwiftUI

struct LocationsView: View {
    @ObservedObject var vm: LocationsViewModel = LocationsViewModel()
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(vm.locations, id: \.id) { location in
                        LocationCell(location: location)
                    }
                }
                .padding(8)
                .task {
                    await vm.getInitialData()
                }
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
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
    }
}
