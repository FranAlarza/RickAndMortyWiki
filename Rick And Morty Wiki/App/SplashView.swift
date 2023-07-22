//
//  SplashView.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 22/7/23.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack {
            Image("splash")
                .resizable()
                .frame(width: .infinity, height: .infinity)
                .ignoresSafeArea()
        }
    }
}

struct SpalshView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
