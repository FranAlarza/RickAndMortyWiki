//
//  MockRepository.swift
//  Rick and Morty WikiTests
//
//  Created by Francisco Javier Alarza on 21/7/23.
//

import Foundation

class MockRepository: Repository {
    var storedData: [String: Data] = [:]
    var storeCalled = false
    var loadCalled = false
    var deleteCalled = false
    
    func store(_ data: Encodable, key: String) {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(data) {
            storedData[key] = encodedData
        }
        storeCalled = true
    }
    
    func load<T: Decodable>(forKey key: String, as type: T.Type) -> T? {
        guard let savedData = storedData[key] else {
            return nil
        }
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: savedData)
            loadCalled = true
            return decodedData
        } catch {
            print("Error decoding data: \(error.localizedDescription)")
            return nil
        }
    }
    
    func delete(key: String) {
        storedData.removeValue(forKey: key)
        deleteCalled = true
    }
}
