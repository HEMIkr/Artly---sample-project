//
//  PersistenceManager.swift
//  Persistance
//
//  Created by Aleksander Wędrychowski on 17/01/2021.
//

import Foundation

public protocol PersistenceManager {
    func toggle<T: Codable & Equatable>(_ object: T, key: String) -> Bool
    func get<T: Codable>(_ typeToGet: T.Type, key: String) -> [T]
    func contains<T: Codable & Equatable>(_ searchedObject: T, key: String) -> Bool
}

public struct PersistenceHandler: PersistenceManager {
    
    public init() {}
    
    // MARK: - Endpoints
    
    public func get<T>(_ typeToGet: T.Type, key: String) -> [T] where T: Codable {
        guard let data = UserDefaults.standard.data(forKey: key),
              let instances = try? JSONDecoder().decode(Array<T>.self, from: data)
        else {
            return []
        }
        return instances
    }
    
    public func toggle<T>(_ object: T, key: String) -> Bool where T: Codable, T: Equatable {
        var instances = get(T.self, key: key)
        
        if let indexToRemove = instances.firstIndex(of: object) {
            instances.remove(at: indexToRemove)
        } else {
            instances.append(object)
        }
        
        return encodeAndSave(instances, key: key)
    }
    
    public func contains<T>(_ searchedObject: T, key: String) -> Bool where T: Decodable, T: Encodable, T: Equatable {
        return get(T.self, key: key).firstIndex(of: searchedObject) != nil
    }
    
    // MARK: - Helpers
    
    private func encodeAndSave<T>(_ objectToSave: T, key: String) -> Bool where T: Codable {
        guard let data = try? JSONEncoder().encode(objectToSave) else {
            assertionFailure()
            return false
        }
        UserDefaults.standard.setValue(data, forKeyPath: key)
        UserDefaults.standard.synchronize()
        return true
    }
    
}
