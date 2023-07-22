//
//  Rick_and_Morty_WikiApp.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 20/7/23.
//

import SwiftUI

@main
struct Rick_and_Morty_WikiApp: App {
    @State var isAppLoaded = false
    var body: some Scene {
        WindowGroup {
            if isAppLoaded {
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
                        FavoritesView()
                            .tabItem {
                                VStack {
                                    Image(systemName: "heart.fill")
                                    Text("Favorites")
                                }
                            }
                    }
                .environmentObject(FavoriteManager.shared)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Image(.rickIconTabbar)
                            .resizable()
                            .frame(width: 32, height: 32)
                    }
                    
                    ToolbarItem(placement: .principal) {
                        Image(.rmLetter)
                            .resizable()
                            .frame(width: 140, height: 60)
                    }
                }
                .toolbar(.visible, for: .tabBar)
                .toolbarBackground(Color.mainBlue, for: .tabBar)
            } else {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isAppLoaded = true
                        }
                        
                    }
            }
            
        }
    }
}
