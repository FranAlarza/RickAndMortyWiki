//
//  APIPath.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 20/7/23.
//

import Foundation

enum APIPath {
    case characters
    
    var rawValue: String {
        switch self {
        case .characters: return "/api/character"
        }
    }
}
