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
    private var locationsInfo: Info?
    var pages: Int = 1
    
    private let service: LocationsServiceProtocol
    private let repository: Repository
    
    init(service: LocationsServiceProtocol = LocationsService(), repository: Repository = AppRepository.shared) {
        self.service = service
        self.repository = repository
        locationsInfo = repository.load(forKey: StorageKeys.INFO_LOCATIONS_KEY, as: Info.self)
        //repository.delete(key: StorageKeys.LOCATIONS_KEY)
    }
    
    /// Calls all pages that contain all locations, then they are saved to local and if the maximum number of elements does not change they are loaded from local
    @MainActor
    func getInitialData() async {
        let repositoryLocations = repository.load(forKey: StorageKeys.LOCATIONS_KEY, as: [LocationsResult].self)
        if (repositoryLocations?.count != locationsInfo?.count || repositoryLocations == nil) {
            do {
                let result = try await service.getLocations(request: .locations(page: pages.toString))
                repository.store(result.info, key: StorageKeys.INFO_LOCATIONS_KEY)
                locationsInfo = result.info
                pages = result.info.pages
                await getAllLocations(numberOfPages: pages)
            } catch {
                print("Error obteniendo la página inicial: \(error)")
            }
        } else {
            locations = repositoryLocations ?? []
        }
    }
    
    @MainActor
    private func getAllLocations(numberOfPages: Int) async {
        for index in 1...numberOfPages {
            do {
                let result = try await service.getLocations(request: .locations(page: String(index)))
                locations.append(contentsOf: result.results)
                print("GET ALL LOCATIONS CALLED")
            } catch {
                print("Error obteniendo ubicaciones: \(error)")
            }
        }
        repository.store(locations, key: StorageKeys.LOCATIONS_KEY)
    }
//    @MainActor
//    func getLocations(page: Int) async {
//        do {
//            let locationsResponse = try await service.getLocations(request: .locations(page: page.toString)).results
//            self.page += 1
//            locationsResponse.forEach { location in
//                locations.append(location)
//            }
//            print("***** GetLocationsSuccess *****: \(locationsResponse)")
//        } catch {
//            locationsError = error.localizedDescription
//            print("***** GetLocationsError *****: \(error.localizedDescription)")
//        }
//    }
}
