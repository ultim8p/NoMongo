//
//  File.swift
//  
//
//  Created by Guerson Perez on 3/14/23.
//

import Foundation
import Vapor
import MongoKitten

public extension Request {
    var mongoDB: MongoDatabase {
        return application.mongoDB.adoptingLogMetadata([
            "request-id": .string(id)
        ])
    }
}

public struct MongoDBStorageKey: StorageKey {
    public typealias Value = MongoDatabase
}

public extension Application {
    var mongoDB: MongoDatabase {
        get {
            storage[MongoDBStorageKey.self]!
        }
        set {
            storage[MongoDBStorageKey.self] = newValue
        }
    }
    
    func initializeMongoDB(connectionString: String) async throws {
        self.mongoDB = try await MongoDatabase.connect(to: connectionString)
    }
}
