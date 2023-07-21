//
//  LocationService.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 21/7/23.
//

import Foundation

protocol LocationsServiceProtocol {
    func getLocations(request: LocationsRequest) async throws -> Locations
}

final class LocationsService: LocationsServiceProtocol {
    
    let networkRequester: NetworkRequester
    
    init(networkRequester: NetworkRequester = .init()) {
        self.networkRequester = networkRequester
    }
    
    func getLocations(request: LocationsRequest) async throws -> Locations {
        try await networkRequester.doRequest(request: request)
    }
}
