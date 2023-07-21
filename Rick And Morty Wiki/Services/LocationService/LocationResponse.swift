//
//  LocationResponse.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 21/7/23.
//

import Foundation

// MARK: - Locations
struct Locations: Codable {
    let info: Info
    let results: [LocationsResult]
}

// MARK: - Result
struct LocationsResult: Codable, Identifiable {
    let id: Int
    let name, type, dimension: String
    let residents: [String]
    let url: String
    let created: String
}
