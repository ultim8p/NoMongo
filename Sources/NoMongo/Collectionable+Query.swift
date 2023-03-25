//
//  Collectionable+Query.swift
//  
//
//  Created by Guerson Perez on 3/16/23.
//

import Foundation
import MongoKitten

public extension DBCollectionable {
    
    // MARK: Single Object
    
    static func findOne(in db: MongoDatabase, id: ObjectId?) async throws -> Self {
        guard let id = id else { throw DBCollectionableError.missingField("_id") }
        return try await findOne(in: db, query: "_id" == id)
    }
    
    static func findOneOptional(in db: MongoDatabase, id: ObjectId?) async throws -> Self? {
        guard let id = id else { return nil }
        return try await findOneOptional(in: db, query: "_id" == id)
    }
    
    static func findOne(in db: MongoDatabase, query: Document) async throws -> Self {
        guard let obj = try await findOneOptional(in: db, query: query)
        else { throw DBCollectionableError.objectNotFound(Self.objectName) }
        return obj
    }
    
    static func findOneOptional(in db: MongoDatabase, query: Document) async throws -> Self? {
        let coll = collection(in: db)
        return try await coll.findOne(query, as: Self.self)
    }
    
    // MARK: Multiple Objects
    
    static func findAll(in db: MongoDatabase) async throws -> [Self] {
        return try await findAll(in: db, query: nil)
    }
    
    static func findAll(in db: MongoDatabase, query: Document? = nil, sort: Sorting? = nil, limit: Int? = nil) async throws -> [Self] {
        let coll = collection(in: db)
        var cursor = coll.find(query ?? [:], as: Self.self)
        if let sort = sort {
            cursor = cursor.sort(sort)
        }
        if let limit = limit {
            cursor = cursor.limit(limit)
        }
        return try await cursor.drain()
    }
}
