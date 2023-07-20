//
//  ServicesURL.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 20/7/23.
//

import Foundation

enum ServiccesURL: String {
    
    case baseURL = "https://rickandmortyapi.com"
    
    var convertedURL: URL {
        guard let url = URL(string: rawValue) else {
            assertionFailure("Incorrect format of URL")
            return URL(string: "")!
        }
        
        return url
    }
}
