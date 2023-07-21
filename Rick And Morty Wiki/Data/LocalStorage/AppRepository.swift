//
//  AppRepository.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 21/7/23.
//

import Foundation

protocol Repository {
    
    func store(_ data: Encodable, key: String)
    
    func load<T: Decodable>(forKey key: String, as type: T.Type) -> T?
    
    func delete(key: String)
    
}


final class AppRepository: Repository {
    
    static let shared = AppRepository()
    
    private init() {
        // Private initializer to force single instance
    }
    
    func store(_ data: Encodable, key: String) {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(data) {
            // Save the encoded data to UserDefaults
            UserDefaults.standard.set(encodedData, forKey: key)
        }
    }
    
    func load<T: Decodable>(forKey key: String, as type: T.Type) -> T? {
        // Get the saved data from UserDefaults
        guard let savedData = UserDefaults.standard.object(forKey: key) as? Data else {
            return nil
        }
        
        // Decode the data into the specified type
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: savedData)
            return decodedData
        } catch {
            print("Error decoding data: \(error.localizedDescription)")
            return nil
        }
    }
    
    func delete(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
}
