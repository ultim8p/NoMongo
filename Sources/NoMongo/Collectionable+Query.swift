//
//  Collectionable+Query.swift
//  
//
//  Created by Guerson Perez on 3/16/23.
//

import Foundation
import MongoKitten

public extension DBCollectionable {
    
    // Finds an existing object and replaces it or creates a new one.
    // Note that the id of the new object will be taken, if it is different from
    // the existing one, the id for this object will change.
    func findAndUpsert(db: MongoDatabase, where query: Document) async throws {
        if let existing = try await Self.findOneOptional(in: db, query: query) {
            try await existing.delete(in: db)
        }
        try await self.save(in: db)
    }
}

public extension DBCollectionable {
    
    // MARK: Single Object
    
    func find(in db: MongoDatabase) async throws -> Self {
        return try await Self.findOne(in: db, id: _id)
    }
    
    func findOptional(in db: MongoDatabase) async throws -> Self? {
        return try await Self.findOneOptional(in: db, id: _id)
    }
    
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
    
    static func findAll(in db: MongoDatabase, ids: [ObjectId]?, sort: Sorting? = nil) async throws -> [Self] {
        guard let ids, !ids.isEmpty else { return [] }
        
        let query: Document = [
            "_id": ["$in": ids]
        ]
        return try await findAll(in: db, query: query, sort: sort)
    }
    
    static func findAll(in db: MongoDatabase) async throws -> [Self] {
        return try await findAll(in: db, query: nil)
    }
    
    static func findAll(in db: MongoDatabase, query: Document? = nil, sort: Sorting? = nil, limit: Int? = nil) async throws -> [Self] {
        let coll = collection(in: db)
//        let agg = coll.buildAggregate {
//            Match(where: "age" >= 18)
//        }
//        agg.
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
