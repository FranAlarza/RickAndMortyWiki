//
//  Image.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 20/7/23.
//

import Foundation
import SwiftUI


extension Image {
    init(_ image: AppImage) {
        self.init(image.rawValue)
    }
}


enum AppImage: String {
    case rickIconTabbar = "rick-icon-tabbar"
    case rmHightlight = "rm_highlight"
    case rmPrincipal = "rm_principal"
    case rmCharacterIcon = "characters_icon"
    case rmLetter = "rm_letter"
    case rmEmptyView = "rick_and_morty_empty"
}
