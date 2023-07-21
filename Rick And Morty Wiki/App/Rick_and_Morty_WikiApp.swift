//
//  Rick_and_Morty_WikiApp.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 20/7/23.
//

import SwiftUI

@main
struct Rick_and_Morty_WikiApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                CharacterView()
                    .tabItem {
                        VStack {
                            Image(systemName: "person.fill")
                            Text("Characters")
                        }
                    }
                LocationsView()
                    .tabItem {
                        VStack {
                            Image(systemName: "location.fill")
                            Text("Locations")
                        }
                    }
            }
            .toolbar(.visible, for: .tabBar)
            .toolbarBackground(Color.mainBlue, for: .tabBar)
        }
    }
}
