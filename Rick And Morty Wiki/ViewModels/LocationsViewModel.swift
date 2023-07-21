//
//  LocationsViewModel.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 21/7/23.
//

import Foundation

final class LocationsViewModel: ObservableObject {
    @Published var locations: [LocationsResult] = []
    @Published var locationsError: String = ""
    var page: Int = 1
    
    private let service: LocationsServiceProtocol
    
    init(service: LocationsServiceProtocol = LocationsService()) {
        self.service = service
    }
    
    @MainActor
    func getLocations(page: Int) async {
        do {
            let locationsResponse = try await service.getLocations(request: .locations(page: page.toString)).results
            self.page += 1
            locationsResponse.forEach { location in
                locations.append(location)
            }
            print("***** GetLocationsSuccess *****: \(locationsResponse)")
        } catch {
            locationsError = error.localizedDescription
            print("***** GetLocationsError *****: \(error.localizedDescription)")
        }
    }
}
